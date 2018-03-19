Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2356021-1521448750-2-6107739667703977138
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521448749; b=ayM9czOdm+Y+lU37oUbQliXJRLTosrUTf/PbhtaaJSfkP4M
    wKa63WfZZz58pb5EIQR/yJSIpcBrfNuJvF1xWiabVqKejnkf6AWjTGHgLjTG7Oo2
    t283P6WoAy0i178tGVApgF/mJdhnpuxhv57hHrdISj0VUInsb0RkKtd0v4PzRFFC
    f/MeJ372I1bM/m/A1ywKqwQB2R2bFkrsN9RIrJB87owFZ2DlGtOu1vJ3RBnpK+hC
    1BsjrYi13Sv1x9+GQdwaHvKuX1GOatQHwW0JV6OuUs45GXnHVly+DsLGTBB5o0+K
    XzeDWmfLpNY0rFvi7vdNGobIjTqAXBPdjVjGYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521448749; bh=s
    xZDo7fbPXCmtaFXpPmJYiIrKyn5aJjr3JAjV/UtZSY=; b=oA+46lbA/655SF0BK
    yAQXKgTfCSsZhscNvNp+t18FUVmjygFfbAb7BP50XR4K26VFxZ8MXMjJG0hBHac2
    2e8L1XXs+bnTyTDi8BuFAXFDDW5n1AJee7y7HldBVajP0EMDVHPQflLZPEpmY8nZ
    TKFg0kFTfMnrrkLVHZtnb0dbBZnBbx8fiDvifpb2GV+kCtRYRfLHW3kwCh4MDRSN
    hFe5jL8HHeF1WDlizTooGIap+W8QCuPloJZnR64+P/8Q2UT8Am1bW0GRIq2b1j9H
    m0UCH092rp2S+VPuWkIlQUR7HxshtbcU9t/U1PqOK2hXxFbCXEbgojVONrQJVjHs
    supFw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=v2UhENJ6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepffgrnhcuvegrrhhpvghnthgvrhcuoegurghnrdgtrghrphgvnhhtvghrsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefkedpudeguddrudegiedrudduiedrleenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefkedphhgvlhhopeifhhhithgvrghluggvrhdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepiedvjedtuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=v2UhENJ6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepffgrnhcuvegrrhhpvghnthgvrhcuoegurghnrdgtrghrphgvnhhtvghrsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefkedpudeguddrudegiedrudduiedrleenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefkedphhgvlhhopeifhhhithgvrghluggvrhdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepiedvjedtuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Mar 2018 11:38:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Message-ID: <20180319083850.tglknmwwybdhahfl@mwanda>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836
 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190007
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
Cc: sthemmin@microsoft.com, linux-pci@vger.kernel.org, haiyangz@microsoft.com,
 linux-kernel@vger.kernel.org, bhelgaas@google.com,
 devel@linuxdriverproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 10:53:02PM +0800, Jia-Ju Bai wrote:
> hv_pci_onchannelcallback() is not called in atomic context.
> 
> The call chain ending up at hv_pci_onchannelcallback() is:
> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
> hv_pci_probe() is only set as ".probe" in hv_driver 
> structure "hv_pci_drv".
> 

Your static analysis tool is faulty and apparently so is Smatch.

$ smdb function_ptrs hv_pci_onchannelcallback

Says it can't find a caller.  When I look for function pointers I get:

$ smdb function_ptr hv_pci_onchannelcallback
hv_pci_onchannelcallback =  'hv_pci_onchannelcallback' , 'vmbus_open param 5' , '(struct vmbus_channel)->onchannel_callback' , '__read_once_size param 0'

Anyway the call tree is:

vmbus_chan_sched() <-- takes rcu_read_lock();
-> vmbus_channel_isr()
   -> channel->onchannel_callback() -> which is hv_pci_onchannelcallback()

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
