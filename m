Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1779982-1523430475-2-3545855315952988754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523430474; b=PKh9QkQkppFtd6hE1/H/xSGhtuZd/JLFkxB6ixz2NFf4scqdFR
    C8H8eLU0hVmfHGOVsF/fBtN2pMyAONFlTncDtJ3r62mtK7C6ZPr1FcY0/F9EOWX3
    tThn7QrYtLacr/PnnnwutiRiv5T0Onjr/TqxN9RL9GSrQ574lixsTlbZY32+bOau
    kwggyDUDGrGp3HMOhgeVI0SNTZ+seUpAk+z3tJv08dBpOunZhsMWnXtGcr82YArA
    2FsBqrsDhnAAJ/zCg9HED37KvqwsdKrCxe+qzo2/Cf6hBF0RdA6bg2mvQrZRYAF/
    mToeTeh3LQbf/+hfKqX4KMe//7a8TfVqQh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523430474; bh=DX/tz
    K9PorU9X/n7NUz26KCHAHG8F6LgV2hAUgjojAg=; b=wV5E9b3bjJ2glbkNzbBOY
    68+CLhr97W4Un2Up5PKpirZBdOyE3RBSvB9Q2S54ysyHp2/PvFWLtMn2TVzbcPWe
    ML5WSJlFtac6NyYHrNqQU1E5ZcFTntY2OC8iSO5mje5G3ki6zw5aEMiRfxn/uKvf
    hguv195Sl9HZv1F/lEcK2mznJ3ZaUgce4lnieOQwNzvKuUzulejBIZXEb/pevLo5
    UAmElUnVLHKmcK5hnEux4R2wN0ldyM/R1re7KTxyA0LZYJACzS6mOodNJxl/d/+Z
    h6x6itDPAGvKMLafE1jVKnBWcU/zWPLimu9rp5+DDq04XUa+0tP+MG6+PGCe7NBX
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KabgKSVl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rC3bXXgj;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KabgKSVl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rC3bXXgj;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPTmYKrsjN/e36dyd7BAEj087qLKtuSU2ATwF/BPt1IgLvdPg3bf18JBrP368FAEcQ143shHAm9qFWOwIxr4j5uO5rSTn4yX+RTkk4hwMZq+ozGlJ7ve
    +EahvzUp5ozvRTLLcwY2QPgLeD7AqKLsETDnnJXRSLIvi/cuqyibTE1T1Upe5a3HWWtBLZ+xkRvC+55ar3bU4d7Y5jnv/8SLs2U6ioF0iQlQpF0mqfr9TjCX
    Ykwxkd0tnLx5X4/lXWT4og==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=_JnzHNP1hwmDxSqY1aUA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+9eI+nvkI7cM907a365/j5t73ZMkvuM27/2yEmfisKHohQ2/F+kP3CkNB3TAdC2kAxoJgsJQ==
Date: Wed, 11 Apr 2018 09:07:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH 1/2] staging: irda: Replace mdelay with usleep_range in
 stir421x_fw_upload
Message-ID: <20180411070742.GE10795@localhost>
References: <1523410174-1553-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523410174-1553-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, samuel@sortiz.org, gregkh@linuxfoundation.org,
 johan@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 arvind.yadav.cs@gmail.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 09:29:34AM +0800, Jia-Ju Bai wrote:
> stir421x_fw_upload() is never called in atomic context.
> 
> The call chain ending up at stir421x_fw_upload() is:
> [1] stir421x_fw_upload() <- stir421x_patch_device() <- irda_usb_probe()
> 
> irda_usb_probe() is set as ".probe" in struct usb_driver.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, stir421x_fw_upload()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

This all looks good (also note the call to usb_control_msg(), which may
sleep, just above the mdelay()).

Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
