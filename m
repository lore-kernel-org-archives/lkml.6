Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2742904-1525780172-2-2743126377273257352
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525780171; b=ZfXCrwusAxk47Q7kLLUk5KeyXINYtUUbWj0RYyreqiqR/hjq2F
    qGuiCHn54yRR0Ba/HbySoHHN4Q2wRCUeAjjIpY2NtRXFP925g7v+aUwXiBet5L+V
    Sw+B2OWfZ4Q10MBUto1SNgLkvvl+I4BnKELeXT51R00jSOprzHXphet3svX2T0Mr
    vhY1eD/Ohxs82xEFgouBxP45K8joPTHM9qm2PhrSgKhJCTHzEffa0XD0HQfzQdnm
    Z+KFHfAuasBzOhTFftAleJqOiqZUXzBM6mvLvkYtMjLtriDIUwDFCl/kT5/WrorK
    +zp4lcdo0r15qiyazoZHHR8XMuu26FcDkV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525780171; bh=I58sr
    +XNJChSYayeW1G5dVJqw3rmvAsbBB5jIfJCgjw=; b=a2R8RyZeJ39FBEIILxjWL
    v5teu/IHK61yEklb3jbpZrDBOdJFwFb51mLWMy9by0XkgDNxnGdZ1lNmlmAopBlB
    OI1muiUpQakYXygu4Bdsoe8zz03z6mDE/mt2dI9bkZmsM8iflrYZBivUc49mFfbU
    RW1NSaCIWH5U/Vg2cvRrt8z6Kiz23wLarB4TmgPECPRwzjO1c+mWruBRDA9sewXy
    0dUWygxO4K7fzybAlljWyPDt3RjGkASXAZiAuuOmGFGZRv8wlOz81z/0SDpfScnQ
    jap9elf6bwirf/15DGc5n0OnkkY3yVCDQjwvyU1E0+btco1yaaPbMG22lsqtaFnL
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=l6gKerD8 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qbokxl8z;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=l6gKerD8 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qbokxl8z;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIXlNx2Cnn0DgHDejEbG2XtpNpKORa5wgK7Pje5eX0fM/N1Lk3MXzKfShW1XRbRDm4egJF/29thfCCDYaVx45hq1z7gKzNtjZwNcqvQ2VFV2cx1atULY
    qm8inLS+gb3OmizVwnvDgP2sIUQPlHsgBlK9ptAHzLarnGBFpK7C+jN9Sq4Mtr8hekfmJJhlVHuyiCzJIU664q4q3C31+MfGx3b9iu8Qkg1NSvf8TOtDDMqc
    6Ph7fTR/0tYjZRPxgwxmpw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=Hf5zQKraihAZFWdyVh8A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZq8DXIFQsa7Rx7UP9dxByeqXOTeKSTN3ClQgsGInO4d92IliSjnFKokDHi7dQTRqmEsJdzrGQ==
Date: Tue, 8 May 2018 04:49:31 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/7] staging: ks7010: Replace license boilerplate with
 SPDX identifiers
Message-ID: <20180508114931.GA28937@flashbox>
References: <20180506220304.13040-1-natechancellor@gmail.com>
 <20180508114313.GA23319@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180508114313.GA23319@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 01:43:13PM +0200, Greg Kroah-Hartman wrote:
> On Sun, May 06, 2018 at 03:02:58PM -0700, Nathan Chancellor wrote:
> > This satisfies a checkpatch.pl warning and is the preferred method for
> > notating the license due to its lack of ambiguity.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/ks7010/ks7010_sdio.c   | 5 +----
> >  drivers/staging/ks7010/ks7010_sdio.h   | 5 +----
> >  drivers/staging/ks7010/ks_hostif.c     | 5 +----
> >  drivers/staging/ks7010/ks_hostif.h     | 5 +----
> >  drivers/staging/ks7010/ks_wlan.h       | 5 +----
> >  drivers/staging/ks7010/ks_wlan_ioctl.h | 5 +----
> >  drivers/staging/ks7010/ks_wlan_net.c   | 5 +----
> >  drivers/staging/ks7010/michael_mic.c   | 5 +----
> >  drivers/staging/ks7010/michael_mic.h   | 5 +----
> >  9 files changed, 9 insertions(+), 36 deletions(-)
> 
> This patch does not apply to my staging.git tree :(

Looks like someone beat me to most if not all of my patches (they
weren't pushed out when I did these on Sunday). I will take a look
later today to see if any of them are still relevant.

Thanks!
Nathan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
