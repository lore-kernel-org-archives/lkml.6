Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-533863-1522457361-2-7523754799537677992
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522457360; b=Ms6Rpb6EiA1q/7Q3B2krTkGXbkXkV6DcF+qNgQlEy9zFVZDTef
    4hQDtIr2wp7iDVvQ69LHvuCZugJrHpJnlAxBk2G4YGYvDbMM1nvh3rPjNB1MWQl/
    XBnS0BCUajz9VtOQrZiuxkmWsSSwnp4O4E7USSWPvbrJpPmJ4PAstQVXO+VegP+P
    0GyXNWnKKB4nCS7HR0uC3jgHa+8ZPg34GhJWAgiFOxiqO99qcrlJUNmgWDejTBFn
    BQhh8NviVy21fGkd6WpOFcVSHLCx94RkBORNIOOPmcBXi3sJDY1WXDuz6pZ7KOia
    6ICPbC1rne5rFvjz8bDglHW91vIioVfbIxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1522457360; bh=GT7b4uK4IfSTh320FIkuNWiypQ1yyK2
    neLBW0ZflaGI=; b=jl1WtnVWWC0Gyw/upoNXo5iwYgt/v79CjuUwatjOU3jHynp
    mXGZM7FCPYWj7mJsszGBwSLkbTHGGqo9OpyGezIw4Mro5eJkrcbul3o32Q6rid5/
    2vrBixo7P79D/2YzhqdKGHUEWWHllvcjDhJaacGgJ75kV9aWyD79ZpZu3wMYRVmJ
    DJmlP3LvjaYUVO9G3wIq6Oa8y/oAsPwJoov25z4NZcpV1AbTASwbp/2FFqU52Ecx
    5Ls99YyWGkmdOqXEi6anLSiTqUMH6i9NVgqRXR/Hc2py9Ous5bFjWx5UVtJfnu3a
    pwMntPXNVI9a13wWIuWJOdQrgp9LBnMt6WQtXSg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P5SaalFw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P5SaalFw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLXHn2ca/hPrg9rPY43B3iFCHAKOOKy37NZDOZTYWWXO1PyZUAyTZgEuz6uYEhpl0+pmNWPclWpW1WCKkq50aBgqwMaJxMwAddNjyS+/BMjQr02tqRMe
    LzymVQ1uq+SxgAJOMoQif9PuZqP4mqpsUApJmxj/Xw0BJ57vB2OIPo0dfkaePEl1Ppaus5NrkeEdTrwWxWta43sphfLZH8/MBb+j9KrTeQN5/SIjh/4lzJSX
    Pw4uARENmBncZgO1iu49pg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=R4fxTKrshSIA:10 a=5P4-rgDjW2YA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=04xfJ39EoNQtbug5W5UA:9 a=gsAaQq8Pz0pvBtWs:21
    a=gqXmUOhHAv9hCyZS:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v5] PCI: hv: Make sure the bus domain is really unique
Thread-Topic: [PATCH v5] PCI: hv: Make sure the bus domain is really unique
Thread-Index: AQHTxSijoP6WPdZS9U+Gegx1alv9bqPovLoAgACTkID//8QzgA==
Date: Sat, 31 Mar 2018 00:49:09 +0000
Message-ID: <F31FD99A-2356-4659-BEC1-91CAE1920B90@microsoft.com>
References: <4BF97B43-5339-4750-9704-23D6AAC4A01E@microsoft.com>
 <105A3FAC-23AF-40F9-8B83-F00DED14EC43@microsoft.com>
 <20180330212311.GB9322@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180330212311.GB9322@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8::529]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR21MB0281;
 7:/qBVEbClr05Y4ND0UehaLSYR44Eh1/WBgGSzN2DNqX3O78O+f1CQ/nwl+5+Iumt2KTI8KpjqtBCghWG1LV66lXnfYfUGhAeCbQhnIPLoMcLwlUUhyIqfTFTiwJMP6+VMS3uuJeZsOWLgI7VBLFgnh6JV2HJdMw0sV3TKYrXnSADptytovlLl0M/Kytr4sQK3nhJROW896nYJA58diiua8dutP8YI9hj0SRsZUkamZ5REfJKmiTQK3hjqvcokRTNL;
 20:jwUPg/ateW0qopt/Bys0K744IDWU6NNfRqd2p422Qsk5wyVLn34rifptjtm8dnBt5Pict5ceST5jyvohxCzaLqmkV2pYejTXJ1t2EueqVWSwFs9Lq33P8alla9WRjsSPtAARYiYGmhTxfKGneLp/N6enMvG13tz5Np8zwkdMxKY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90e24c64-8464-4c77-f922-08d596a13732
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR21MB0281;
x-ms-traffictypediagnostic: DM5PR21MB0281:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR21MB02818681B34FAA87F5B69BB6F6A00@DM5PR21MB0281.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);
 SRVR:DM5PR21MB0281; BCL:0; PCL:0; RULEID:; SRVR:DM5PR21MB0281;
x-forefront-prvs: 062899525A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(39380400002)(396003)(366004)(346002)(199004)(189003)(40224003)(54534003)(6916009)(25786009)(229853002)(72206003)(36756003)(86612001)(83716003)(2906002)(33656002)(14454004)(82746002)(478600001)(10290500003)(8676002)(5660300001)(305945005)(53936002)(5250100002)(6512007)(86362001)(6116002)(99286004)(6246003)(105586002)(54906003)(6486002)(7736002)(4326008)(81166006)(81156014)(68736007)(106356001)(3280700002)(3660700001)(8936002)(6436002)(6506007)(59450400001)(76176011)(10090500001)(102836004)(22452003)(186003)(476003)(446003)(11346002)(46003)(316002)(2900100001)(486005)(97736004)(486005)(2616005)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0281;
 H:DM5PR21MB0826.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: 7ybaj4ox7O/XUd4QQ4QXEPX/DghpHQr5yTBr8ekb7UsjY04moGkiljh/B1oSugHpPIqr7Z98QWIgrzjvjuNBGOaZ845MwMVn2ZcwBAZySyxbO/8h6B7YdSQo7E9WRZnN9gMz9YahVSznbCjYcOF/ycfJb2bVAB3lmX24MkRM/t6ljc8ALNurtFnL6w0BjolgqjsjVsz0Z17JYi9eC+2xaiOvzYoGE2ccfj+7mx7hpsp3QpJItQHSedelHWPfwI6tkIaqroQTkIYjT1uPix5mzvQBGyLgLiQEQcLDz/FHcfQTSLpfL4vc8WcnJvgEburQDwC3DlVs4bxFyXUqq9sxXV03KOvFk/JJXY30kw+B9xXd3U4CWfFTyjrtqf3/L/eg36c9dHaP88tC9mBNJ56jswK7JIWO8tqOARU33TVRV+4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <A2DC99E60829CA4AAC1B53FEC1CAEAA2@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e24c64-8464-4c77-f922-08d596a13732
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2018 00:49:10.0820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0281
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>, Jake Oshins <jakeo@microsoft.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

	>On 3/30/18, 2:23 PM, "Bjorn Helgaas" <helgaas@kernel.org> wrote:
	>   >On Fri, Mar 30, 2018 at 07:35:04PM +0000, Sridhar Pitchai wrote:
	>   >commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
	>   >domain") need to be reverted. Also, we no longer need it as commit
	>   >4a1626dd233e ("netvsc: transparent VF management") remove the
	>   >need for it.
	>
	>Do you mean 0c195567a8f6 ("netvsc: transparent VF management")?
	>
	>I don't see a 4a1626dd233e commit in Linus' tree.
	>

That is right. sha should be 4a1626dd233e.

	>The connection between 0c195567a8f6 ("netvsc: transparent VF
	>management") and this Hyper-V domain ID issue is not clear to me at
	>all.  But obviously I'm not a networking or a Hyper-V person.
	>
	>A hint in the changelog about what that connection is would be nice.
	>
	>   >Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
	>   >domain") so we can reliably support multiple devices being assigned to
	>   >a guest.
	>   >
	>   >This revert should only be backported to kernels that contain commit
	>   >4a1626dd233e ("netvsc: transparent VF management").
	>   >
	>   >Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
	>   >Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
	>   >Cc: stable@vger.kernel.org
	>
	>This backporting guidance is very confusing.
	>
	>4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
	>appeared in v4.11.
	>
	>0c195567a8f6 ("netvsc: transparent VF management") appeared in v4.14.
	>
	>The changelog and the "Fixes" tag both suggest that 4a9b0933bdfc was
	>flat-out buggy and should be reverted unconditionally.  That would
	>mean this patch should be applied to v4.11 and later stable kernels.
	>
	>But the changelog also says "only revert 4a9b0933bdfc if you have
	>0c195567a8f6".  That would mean this patch should only be applied to
	>v4.14 and later stable kernels.
	>
	>Which is it?  You can answer in this thread if you want, but Lorenzo
	>will ultimately be looking for a v6 patch with a corrected changelog.

It is the Case 1. We just need to revert 4a9b0933bdfc. I will remove the
reference to 0c195567a8f6 altogether in the commit message.

	>
	>I think Lorenzo is out this week, but I suspect he'll look at it next
	>week.
	>
	>Bjorn

I will send out the update patch version 6.

Thanks,
Sridhar Pitchai 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
