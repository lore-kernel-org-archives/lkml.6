Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1763006-1522225177-2-4980174961073010630
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522225176; b=vy46sRsChni690+cABUAkD97ftkBG9oAyzcRtWWN+0Ydvwp
    wg2HSn+gZYbxBLVVOIm115mfg0RD80VHbTOVFVBmcBD9HOoFD3r6dTFljYuPTEk3
    crFebD90kRtOIafXTqX172o3jhpDVxcugUUvxaSGHnIgGmpSX83+y0KWrm7WBcQF
    FHAHBT+FKWP8i0KJ3cU5kQ5sE7plAAzfCenYWVXoFw2GgLK3t9OVLnqCgmSzlfPt
    3pnmnRNzGky1JIgt2R+VGGitLLuEXX3u4wyxZSRPAkzYtIZMBAJbvfylo3A8IKhy
    H3/le1xCNZRd1SYRTZjWb45mtWhpgccgZIMQOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522225176; bh=5
    HtMs+NSDhl1aHgpn1uyv+5IUoTcYxq8Yrolq8QVCmo=; b=I6I1APX4mfmK5Zk0e
    cJ4KP8hwn5chdBWfNFfmJzo0lw6rLzdgxwjYh18lJ4LuvklFO9EsYlxl81hS0Z84
    WQhAEQn2DtX8ADw2kn+NRwZ2T7j7qiZoXM2KRDoIoLKWDOku7+G7k5dmrHf7vVOB
    akdO3vyMXKsm0zp1ow8ygnt8qYB//HNZFV6BCMbBmEd7nz/U+atC076FDoqgPqd3
    OsdtMDU8wcvDtNhDLPEc5fyWVfP+2gW7Bm3sRCLoZJxYvSRkJs+twNmgnKhwEaMd
    vkq0dco/d3VM5Lpvy3U/GKv6hrewRk5CXgiJ7QUSrk8p8pDsFTlFjAYArqdKwhlf
    +9r+Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLsREMJT1YHMSmfwvwgJnWv4LI/TcZ6aK5c90M7NSI0f4wtqdNOJBncjeUcC2tURv+UsrR+go4+dsBw4eALSRz1gUDv8kdMAD7lfLHYHylg4O5S8tML7
    UwYGzpETfUFvCfS9S10dfn8B84f7jEMhID126wrK50khWyiW/BPTLE76w27H0Btd+A3zTIsZRRJR3MUxGPdbPKWf9ju+DcfxTTXzABwhWpIUSXOOlmQDDpBd
    V8iX1QL76oGmbMSBQLtkPA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hSkVLCK3AAAA:8 a=n8i27M1mAAAA:8
    a=DDOyTI_5AAAA:8 a=aUSvob-bZbhDfBvD9FcA:9 a=CjuIK1q_8ugA:10
    a=cQPPKAXgyycSBL8etih5:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 28 Mar 2018 10:19:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martijn Coenen <maco@android.com>
Subject: Re: [PATCH] ANDROID: binder: prevent transactions into own process.
Message-ID: <20180328081921.GA14201@kroah.com>
References: <20180328072903.155938-1-maco@android.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180328072903.155938-1-maco@android.com>
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
Cc: amit.pundir@linaro.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, arve@android.com, maco@google.com,
 john.stultz@linaro.org, tkjos@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 09:29:03AM +0200, Martijn Coenen wrote:
> This can't happen with normal nodes (because you can't get a ref
> to a node you own), but it could happen with the context manager;
> to make the behavior consistent with regular nodes, reject
> transactions into the context manager by the process owning it.
> 
> Reported-by: syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com
> Signed-off-by: Martijn Coenen <maco@android.com>

Does this need to go to older kernels as well?

I have a script that picks up everything the syzbot finds and tries to
backport them, after they are applied in Linus's tree.  Might as well
catch things before we have to rely on my script :)

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
