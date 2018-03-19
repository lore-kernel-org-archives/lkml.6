Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2526322-1521455380-2-4908768166065150581
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
    t=1521455379; b=ur3KaHRHKQbDz/t5PSRJ53sOsH7FSyb7UFS543gsqoIDm0A
    XqcLQui+oVboDMaTNjXT4LSXTSrkZnZzPBKlV8bE7qbivHVJrpoi6UWHKmy2dX+l
    k0GNa+Vrm2QAOaZsJzbmu5l1scxLhEW+WI8Boj7PW5SBM08xu+LeLuTK+TrS7H84
    DoqO4vmt2lu8IxwB4/KbDimPDrGUXN4LwU2QK7MFfoBLhuejHAx8KOpni1iOGDvP
    5MBvi5eEr44fIMZh9oLbv08ByFUqpS58qnQmXuHUAoXrc/aW0TgK5N6G4IQPEJfk
    GL40u925o+RdnB+Su4E2sPZt/sFlVWT0A+SI9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521455379; bh=S
    K0imfb1kSH/nOLVcmHnR+EuhuqYjqXdCvamRfSJTrg=; b=Em3u1k64vuxqhRXLu
    bkutyxUJ5jttKDJhvBhVvRoW/Zh3cJO7aS0A/87AXWnnTUlBdILNbCoCoO33M9qP
    TMyk+26equIw+8NEsD7OPnBvLW1H7xe/EovVD8Lu2ewuVwY4z3IIeZERTQAFeAnR
    lHol8CxF/An4qT5XTCL4OLOSKlAvZgGPVJawI34jdMWcqCXXdTmOY8zrOHuc5BSV
    NTCI6bbfmu5qvAWKQzv0hWM/OFAFBwu/cGThRQjrEjjbfzlwFY9s3SW4zlrNyv6i
    aU2Sl1L151kWMs2m72QYeVsikN6sv6jR6qxxyXSUdRndcgU+YV2dxA+g9QWNQWVi
    3RIQQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ByCGmMq3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhgguggjfghpjefjgedufedttgfgvghssehtjeertddtredvnecuhfhrohhmpeffrghnucevrghrphgvnhhtvghruceouggrnhdrtggrrhhpvghnthgvrhesohhrrggtlhgvrdgtohhmqeenucffohhmrghinheplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeekpddugedurddugeeirdduudeirddufeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefkedphhgvlhhopeifhhhithgvrghluggvrhdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepheelleeguceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ByCGmMq3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhgguggjfghpjefjgedufedttgfgvghssehtjeertddtredvnecuhfhrohhmpeffrghnucevrghrphgvnhhtvghruceouggrnhdrtggrrhhpvghnthgvrhesohhrrggtlhgvrdgtohhmqeenucffohhmrghinheplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeekpddugedurddugeeirdduudeirddufeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefkedphhgvlhhopeifhhhithgvrghluggvrhdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepheelleeguceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Mar 2018 13:29:20 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Message-ID: <20180319102920.tx6hpjyyqooij5xi@mwanda>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
 <20180319083850.tglknmwwybdhahfl@mwanda>
 <63a95bfd-0199-b935-b8d0-2b73d82e8d46@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63a95bfd-0199-b935-b8d0-2b73d82e8d46@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836
 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=718
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

Smatch tracks information about every function call.  When a function
pointer is called it maybe looks something like this:

     kernel/module.c |   SYSC_delete_module | (struct module)->exit |    INTERNAL |  -1 |  | void(*)()

So then we just have to know what functions are assigned to
module->exit.

I also filter based on the function signature "void(*)()" because
there are a couple places where we cut and pasted so the structs can
have the same name and function pointer name as a member but take
different arguments.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
