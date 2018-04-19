Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2066586-1524113962-2-15740668817608550751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524113962; b=W1zXZn8Zv8SFSMJ3uMwQkft7M3eWRcTkGZcwuGN4gnXn2gTUYw
    qcfqEfYAgK+sAUhWI+Jey5ixCbebQa3FGKCE926Kcy+f8fyKsXf3q7crtMoUZ9Gq
    7rw07/MdmB77A7DaqKmjBm4xFBsYqCM7zg1r2UEaMAmMLid2Qv6k11ExwDJNcUr5
    UkNH81oni4wBPpbW6rSPkGqCB7AwhmxGInRHX7f/rGRxuYCueDEDbaSbUjJw66x+
    mPQff6MKQXRcvMFqXjd2DA7iUjdnLhj5/JM0Ai/6b3VeMIsiFssznfO9bjIkQbwf
    +YMJAERxPL5towJK12ehSqeISWJUj05G5XYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524113962; bh=qaI93
    u8RVY9ROzj0WMTTKPI8A6YbADB6ofvXduz4U7U=; b=IOziOLPJWn8PhhG8zMvgA
    8JTU25gfYn22g5W+HNT8Wqe2Jme/laDREoT9AP6GHJ8K9GiIkcuIujnSI1ytJ1V5
    ENi3CEGUE7gAPhvzIa563UaRSXOSxNmMtuFkO3m4o7kkbTvuCER3kDXYpMr5HbpA
    a3XlV0OBg0B2uUsbYbNh/NoJbpJT6FqL+lp7zOerkV0IbGXUXspozlV7St3Xxrg1
    CwRK969OvU/jdUIBwMfg4/SktQqIT5Q3pKdIPHkru2glkOiylkUg2g4p6bzR6dAz
    1MCcVu/6hVxZ3DcqiVfdOrErHqSUO3Dk9mNO5SOF145DtE1JvI9LIQ6VAJ5A9Fpw
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KbjTpVbe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KbjTpVbe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBHVJU7YV4ekhqjSh2toUl6Eqpzu+SO3aiNbZvpd2jf1vSyvndDY1f4h/hmFD5PbBSbXOEGFdXaYvbvDG/JkyIVQBpuxiNcToAzYr8x4OQXccdMCyWPE
    SCgV3K7N6kH5jjI0nzum5nfnjBdnKDrOn/KUZOTbNfINfRIsV9oCNyyPtAcm5cZB69fLI9IXrUO8PDrjrsc11bBQgBxW1TuLhcwjBUkkXKKifi89KXn/8j5Y
    YeE8Lm8ASHz3/XKhO2uQ2g==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=R4fxTKrshSIA:10 a=qcIjco1Mu_QA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=VnUAGWa3ynBMnxbBN0gA:9
    a=zT8uCUQNdxnd8HpH:21 a=HKrLZYX5ksRRdnSs:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Long Li <longli@microsoft.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: RE: [PATCH v2] storvsc: Set up correct queue depth values for IDE
 devices
Thread-Topic: [PATCH v2] storvsc: Set up correct queue depth values for IDE
 devices
Thread-Index: AQHTwieDOFEPhIGzxkyq2vCO89MZ9aPfnEKAgCe1+8CAAEiXFYAAFfow
Date: Thu, 19 Apr 2018 04:59:12 +0000
Message-ID: <MWHPR2101MB072916BAB0F56AA2CD8C444BCEB50@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180322214718.29547-1-longli@linuxonhyperv.com>
 <DM5PR2101MB1030FD5B6261CC7BCF0092D1DCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
 <MWHPR2101MB072978A101FEFBCF2D32E872CEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
 <yq1bmefna14.fsf@oracle.com>
In-Reply-To: <yq1bmefna14.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR2101MB0810;
 7:c02yoXG1gA6KRSspoijLtZp2X18iVNEIiOmyLqYdqwr8CkfBTFv1RvmS24xzEKCXTNlFC1ZQ4mAhzEQG9PNNBmnf05BiCesb3DoSJMXSlzjlMhSyZFxA/6LEwvFwtGXKkxAoNJgFobPUHNbQ0FC7rpBWzjDGwB13RnzA8diXDsjguDy/gYwFGrSOZqFtvi3j6yWmLeE4tb+aFjYio+eHlIxJ6jJJItwyNsdgtsG3Doe14ShE3Jh5W2O6T4eEtdwh;
 20:p7fISvEgj6bV5Ck3WUuBTgHjQH9vT0TZBvT8cXXzWdrRshpAShODFQ4n7wd2AQkmPE5ef0XgFd9QSE97ZziKonRrGH5pA1FXKEUxrszmXpXQZnxsaCJUt+Kb5ifRCSVoCeWMBywR3vUabM+LxToDmogsublop67xTtn1nK1TXO4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);
 SRVR:MWHPR2101MB0810;
x-ms-traffictypediagnostic: MWHPR2101MB0810:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB0810333DFAFB816A6CA6BA81CEB50@MWHPR2101MB0810.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501376)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:MWHPR2101MB0810; BCL:0; PCL:0; RULEID:; SRVR:MWHPR2101MB0810;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(39860400002)(39380400002)(346002)(7736002)(186003)(316002)(6116002)(10290500003)(54906003)(305945005)(6436002)(74316002)(99286004)(2906002)(86362001)(229853002)(76176011)(7696005)(478600001)(86612001)(9686003)(55016002)(5250100002)(81166006)(102836004)(2900100001)(53936002)(10090500001)(6506007)(25786009)(476003)(5660300001)(11346002)(4326008)(446003)(22452003)(8676002)(6916009)(33656002)(8936002)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2101MB0810;
 H:MWHPR2101MB0729.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en; MLV:sfv;
x-microsoft-antispam-message-info: aBgCGXK1+fJ4N14b6CFfcqpIx5rTgWb5f5/RQRV8Tb/AgkzjyQlxxb8nzWfmRrFwOfN9s9BukbOaPVb/ANkrZ7Bwt7VMvWFGYXnFApFJTnsIAWrxkVpHXbfmOsy+olPJW5xDCud9ltQTyXecpJtNpgYa+uuZnCDRhCU2MDx22r4G5ZKx3X9chK6bxyHvc7nN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8b73e2dd-bc04-4352-86c1-08d5a5b24b02
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b73e2dd-bc04-4352-86c1-08d5a5b24b02
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 04:59:12.3074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0810
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, "James
 E . J . Bottomley" <JBottomley@odin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 Long Li <longli@linuxonhyperv.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Subject: Re: [PATCH v2] storvsc: Set up correct queue depth values for IDE
> devices
> 
> 
> Long,
> 
> > Can you take a look at the following patch?
> 
> >> > + max_sub_channels =
> >> > + 		(num_cpus - 1) / storvsc_vcpus_per_sub_channel;
> 
> What happens if num_cpus = 1?

If num_cpus=1, we don't have any sub channels.

The host offers one sub channel for VM with 5 CPUs, after that it offers an additional sub channel every 4 CPUs.

The primary channel is always offered.

> 
> --
> Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
