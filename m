Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1533320-1521817436-2-15394119697864054112
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521817421; b=hCZ31iQRcFdR+2kTCUnzSL+WjgvLnbROATVEF0gef5FhLtr
    4SiYexvXvfGUTdvCuspycOumEsCvgmZ6TK/zBJxXYhGSA9glKgMA6djGI/tGIsTv
    1cMle5EI5B9UVom+SOAvZd+EKcfjQDtslC8R/mxsSdUXuiPUssT0i+EKnAPhoAOC
    4D073EdU3MEGbClmOu89eLBGsfN6z+BP0wEk15jSAH2nGLBjeJBz10kTCcgfDQ2k
    ldUeGuban16JesHKHn2XlaR4+gtQBEQKIZmnsrxbtBa4GD/rilDAK8i2MssAHNSF
    YKT4Rjtn1LwWX4BO3G+ohmkBQ5kDzPuEKhBOpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521817421; bh=S
    LYxqDrtxmPdzDSa7oAtBQzfxRIkY1Qk/7bIO9CPmSo=; b=PGF3I6YKahi/rnasO
    MXX8lhZ1EY6yHwbGAfIhoTtWAXI9GzhkVpgzri++pwrA9Br+ky8CR05mUJukV8YE
    oKtlPro+nVHLk5Frwx9SMBYVqZ2dSx0i+Sf66f0Kopmqoeksvrffe/PBLOtXNEPG
    Yb8UfZmihWrMP2qOMH4jfgSXOwquBqC+C28Ydj6m1uEJU93u7/+xPz0Gc/3EWxSH
    6XVi1za9is34O6Ypot7ZrtYhV9wM6hz1xwX2fn3d60evfh0cPWJaJpO9Ms8u6nAp
    hMoZ/5SUAEC0pf+rokmS0AR379koRMtJYjieyrid13LRh+eH1UrJVU0iS9qdn/KO
    H89pQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=rnXco5yL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=rnXco5yL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/9] staging: fsl-dpaa2/eth: Move print message
Thread-Topic: [PATCH 2/9] staging: fsl-dpaa2/eth: Move print message
Thread-Index: AQHTwq0RJrMOL7UTVkSRtOsSjoWnbqPd6kcAgAAATNA=
Date: Fri, 23 Mar 2018 15:03:29 +0000
Message-ID: <HE1PR0402MB2700B5484AAEE6F1E5799DEE94A80@HE1PR0402MB2700.eurprd04.prod.outlook.com>
References: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
 <20180323134413.1532-3-ruxandra.radulescu@nxp.com>
 <20180323150126.GA12656@kroah.com>
In-Reply-To: <20180323150126.GA12656@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0402MB2841;
 7:2IyjCQiC8kAx6kp4hftrOd20jKVJTQyN0ErYGjXj7AJgErfxcrm8P82g/wcsCoNYYnk6Ao5D1kMpYdNNINZuBXpE9Zd/e6iN1oFa3FvBkmUzL8tS1PZ/mC2YRkPdrgFi3V7Qf8gUNdUtdzWE/2LssDRza5Dn5/uo8XP16EcUkyWM7LlxnAfkVnDwpUr979UnjUpmoyKXIxQH2eTyfxDvZcBEsghbZ1D+KeXy3oz9rQRV5tOHLy4CIciRrp/ToZvN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: baa168db-b0e6-4425-5364-08d590cf3cd7
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB2841;
x-ms-traffictypediagnostic: HE1PR0402MB2841:
x-microsoft-antispam-prvs: <HE1PR0402MB2841D5607819102D7E8468BC94A80@HE1PR0402MB2841.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:HE1PR0402MB2841; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB2841;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39380400002)(346002)(376002)(39860400002)(366004)(13464003)(199004)(189003)(5660300001)(53546011)(6506007)(66066001)(26005)(97736004)(102836004)(15650500001)(54906003)(86362001)(316002)(6436002)(229853002)(68736007)(186003)(305945005)(5250100002)(74316002)(7736002)(8676002)(81166006)(3660700001)(81156014)(6116002)(2906002)(3846002)(8936002)(9686003)(105586002)(53936002)(3280700002)(99286004)(2900100001)(55016002)(478600001)(106356001)(6916009)(33656002)(6246003)(7696005)(446003)(59450400001)(76176011)(14454004)(4326008)(11346002)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB2841;
 H:HE1PR0402MB2700.eurprd04.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: Th1/1MdZvebLDs5NZXOE3eFNtPrmPnusxp64UcwLFmO8eFrHXIzEmpy0bUoJZ9RjIwEe6kT8/UuV+mQ3Fbn7z5lhz+QBaIS6MUUMabLd/NeWfHmZpWUg1/GY7ve844LEwELNwsWf7EFPgm4FHV9il8imKroyiNI0dnh6SpMhO0tQuqgg7K3xdJgp/nt31aHcd5f3/XenZIaXoSz0KVJL6uq5100Wf9arR5OIGSpQxzDFDZFSoDvToATPEL/kfO3uzeZrGxrNekk1Rmu9C9QG+WEbm+EPt/CrBD0OrF1pqU7wEgg4O8uqvYedNW5rCy3ZNs7PMyUU+ffQZxBD5mB6Sg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa168db-b0e6-4425-5364-08d590cf3cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 15:03:29.4917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2841
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Friday, March 23, 2018 5:01 PM
> To: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
> Cc: devel@driverdev.osuosl.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/9] staging: fsl-dpaa2/eth: Move print message
> 
> On Fri, Mar 23, 2018 at 08:44:06AM -0500, Ioana Radulescu wrote:
> > Let the driver remove() function print an informative message
> > after it finishes removing the network interface, not at an
> > arbitrary point during cleanup.
> >
> > Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> > ---
> >  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > index beb5959..9fb88f2 100644
> > --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
> > @@ -2550,7 +2550,6 @@ static int dpaa2_eth_remove(struct
> fsl_mc_device *ls_dev)
> >  	priv = netdev_priv(net_dev);
> >
> >  	unregister_netdev(net_dev);
> > -	dev_info(net_dev->dev.parent, "Removed interface %s\n",
> net_dev->name);
> >
> >  	if (priv->do_link_poll)
> >  		kthread_stop(priv->poll_thread);
> > @@ -2571,6 +2570,8 @@ static int dpaa2_eth_remove(struct
> fsl_mc_device *ls_dev)
> >  	dev_set_drvdata(dev, NULL);
> >  	free_netdev(net_dev);
> >
> > +	dev_info(net_dev->dev.parent, "Removed interface %s\n",
> net_dev->name);
> 
> Why is this even needed?  I'll take it but spamming kernel logs for no
> reason is not a good idea :)

Fair point, should I make it dev_dbg instead?

Thanks,
Ioana
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
