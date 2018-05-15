Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1731937-1526350341-2-5788426385084122845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526350340; b=R+K58j4myKzw51jFgu/0PaTmRCwc64PqTkTm/GCYlImwbzYbPU
    55PCn404jMuULBcXEVY5zItlE8r8ND+ZCeH2zggMKcFH4inU/1VZY3ABTa5SzJsB
    cIcO2k17q9Gd083zROFdC2xxrZCcfDhv36or9kMrYg7oy/JPfqdomBVe5rjbUGvm
    Dir9PCKO25v9LGjHH8Fkv7Im+H/ybNIQXieZR0NLJXteWreGhlaUixwoDVoSO+wS
    zGb7OhWUYh1GaBA/fx1BOg8+bKZJ/Ph0kk+9GLUXu8urHWwWXdRhMaADpWovaWK7
    xXpvAJ7ReAB5lmzHd1vTfoteh50qpjscKiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526350340; bh=m248N
    YAwwsa7/IkmnlPIzu8tc2tqtCEb4tYjAe9zDTY=; b=lIrKurehkv7z2WeD80kr8
    Q1c7qcIA8So7NaIst131vu+WweE9PEfAi8VbI+fZ8D6tGPvM2ETD12Uoe4n8mRcR
    ZQJZHPcbRhW+wDyZIx4OdeBHvgpNoeC1qw8OuTBXNvdZI1oi1sm2pQFX4IECEAbL
    4m0MIe4nw08f0JCN5HJDoQaukz0dazr9nRWTQWq64VVQnGjFG6wfBt7LTIDI3gAt
    AQ1bXHwgNdV6D/s2YTTCbzODtlA+7s2py/7dF9Zc44kBvINle45OVR49FzGDJMAe
    4eVm9LQgUFWRQZrXWatVuw5ZKgVeb+9fhu9v6ArJL6wDbgNBtqhVc5kkDLi9v3nQ
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=ibuZXXeX
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=ibuZXXeX
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBqvycwTBCYTp9SDdqnSAbCDGVv4rd0RrnpfUFVBQMh3KbQZSPlPwgQF9AJtc76FtpJe5Cu9UMKNslRuPq3wXlNTnc5DeUT8IZK3kG9cJc5NOrXbM0lh
    8/aBA4iWoSBesnBnfXk6BBvDTcBqCIaac0aNuhKhnyVpoX5fBxw7Rfp/kEueScXZmn9PC9NYAkSd274JWdOFIpREEdz5jaiKXCNaQVKLorDhOxzQQiNcev4S
    lXyz+wa0VPGkr1JmnURjfw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8
    a=o8169s9MT0_xhT9TdawA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....0 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Tue, 15 May 2018 03:11:48 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
In-Reply-To: <87efid7l6z.fsf@notabene.neil.brown.name>
Message-ID: <alpine.LFD.2.21.1805150308400.576@casper.infradead.org>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
 <876044fcgg.fsf@notabene.neil.brown.name>
 <alpine.LFD.2.21.1805150133430.576@casper.infradead.org>
 <87efid7l6z.fsf@notabene.neil.brown.name>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180515_031155_033221_CFC0889D 
X-CRM114-Status: GOOD (  31.25  )
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
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>,
 Lai Siyao <lai.siyao@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> >> On Wed, May 02 2018, James Simmons wrote:
> >> 
> >> > From: Lai Siyao <lai.siyao@intel.com>
> >> >
> >> > Currently we set LU_OBJECT_HEARD_BANSHEE on object when we want
> >> > to remove object from cache, but this may lead to deadlock, because
> >> > when other process lookup such object, it needs to wait for this
> >> > object until release (done at last refcount put), while that process
> >> > maybe already hold an LDLM lock.
> >> >
> >> > Now that current code can handle dying object correctly, we can just
> >> > return such object in lookup, thus the above deadlock can be avoided.
> >> 
> >> I think one of the reasons that I didn't apply this to mainline myself
> >> is that "Now that" comment.  When is the "now" that it is referring to?
> >> Are were sure that all code in mainline "can handle dying objects
> >> correctly"??
> >
> > So I talked to Lai and he posted the LU-9049 ticket what patches need to
> > land before this one. Only one patch is of concern and its for LU-9203
> > which doesn't apply to the staging tree since we don't have the LNet SMP
> > updates in our tree. I saved notes about making sure LU-9203 lands 
> > together with the future LNet SMP changes. As it stands it is safe to
> > land to staging.
> 
> Thanks a lot for looking into this.  Nice to have the safety of this
> change confirmed.
> 
> What do you think of:
> 
> >> > @@ -713,36 +691,46 @@ struct lu_object *lu_object_find_at(const struct lu_env *env,
> >> >  	 * It is unnecessary to perform lookup-alloc-lookup-insert, instead,
> >> >  	 * just alloc and insert directly.
> >> >  	 *
> >> > +	 * If dying object is found during index search, add @waiter to the
> >> > +	 * site wait-queue and return ERR_PTR(-EAGAIN).
> >> 
> >> It seems odd to add this comment here, when it seems to describe code
> >> that is being removed.
> >> I can see that this comment is added by the upstream patch
> >> Commit: fa14bdf6b648 ("LU-9049 obdclass: change object lookup to no wait mode")
> >> but I cannot see what it refers to.
> >> 
> 
> ??
> 
> Am I misunderstanding something, or is that comment wrong?

I think the comment is wrong. That comment was in the other tree before 
the patch was landed. It got included with this push due to me diffing the
tree by accident. I will remove it with the next push.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
