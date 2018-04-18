Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-494466-1524060809-2-2209999244498094082
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524060809; b=sVVZJmEF106CgqhmP0k9gpNHEH912AK7P0mKX5jAu6bxyKI3gG
    viwMD3toSbykPYqdV2yKXTkz3oY5CeBfCsk7WhLFud8geDHwbY4IWBLwAHOwzQZg
    gNkUJtct+oVQGjEVaHVoYoTp1LQN7+AlPlrF3ku3mGY5v73h6J5igJYNYQaUgKz5
    q4ZXE2NfVzURlQ9w/PUTOvY6tBbaR4pxrq7kD1YD8QXBjt10nq0ymXL9RFSew1v+
    6FZ5iT6b6MVZw4AGDcTCZfMSYDYKrPTG9qXBxMQjkyA0+FWFdl8v+JS8whGRZMWr
    aG97f/d16bZJCNZppH7i6PLfitqtTzLOcqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1524060809; bh=A1++0b2uxyjCEKeRO+1w+Q5RYYLw50Go7ybcT1yXo1c=; b=s
    RvY4nq0fHsbwWCbXzcKeQFCmHopBVbDR0qwFNlZ7D2NktS3NsNWBJgC8Hxu9sit3
    hrRNVDs7HYkDFuRbGQuVJ3cTXEhyoSsBgiv/+U1d0xaG7MFLGmDcD9Dm5xbO/2z7
    WLNhG6YrsP7bdk31uqwnWQep3MeM8KkZSkhDKihhNLFFCol/mX0gHbskndKFJ1Z+
    dxXli78zx89q6YvB9La+Sg8fvYuQGSeiiW19BJ6fqDY4yJFf8IRT+Qf4ZddhMM8n
    1DpuCoYrS0Hk579TqWVFCZQbqmREKn+/nT+Dhkm2kJ92KiD0OlomM/0O1DGRh1k1
    k34z660QARCm9GqvqeZ6Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBZatQTNd9ccTRGUUr+8sfTI12BYFk+qSVxAfMEzeg5qYAmqt+WDtE7HFwxe7QTduYurYbe18ziiFC8DLjAYxsyD022meYYIlrLPfdzP0E/zzxmfBYma
    MPfnf5jDqWIxfApX6UA2q8G/g+QsZdyqwEjeYiRKf13GZlh0TmriCYh8qos0Er3x7s7ZoOReJQ8BvAXxjRaxQT7orsdLYtmvEJqMCoHwi6h+zlbdyoxnwGob
    vVeERAVH4z3NAKvDcXZPJA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=0uEGLDak20aBQKKcUsYA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,465,1517904000"; d="scan'208";a="42865374"
Date: Wed, 18 Apr 2018 22:13:17 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [cfs_trace_lock_tcd] BUG: unable to handle kernel NULL pointer
 dereference at 00000050
Message-ID: <20180418141317.76o6yzrhjjeavmd7@wfg-t540p.sh.intel.com>
References: <20180418133831.uef7d77ejdyjtxgh@wfg-t540p.sh.intel.com>
 <alpine.LFD.2.21.1804181456590.5599@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1804181456590.5599@casper.infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Oleg Drokin <oleg.drokin@intel.com>, lkp@01.org,
 Denis Petrovic <denis.petrovic@edu.ece.fr>,
 Linus Torvalds <torvalds@linux-foundation.org>, lustre-devel@lists.lustre.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi James,

On Wed, Apr 18, 2018 at 02:59:15PM +0100, James Simmons wrote:
>
>> Hello,
>>
>> FYI this happens in mainline kernel 4.17.0-rc1.
>> It looks like a new regression.
>>
>> [    7.587002]  lnet_selftest_init+0x2c4/0x5d9:
>> 						lnet_selftest_init at drivers/staging/lustre/lnet/selftest/module.c:134
>> [    7.587002]  ? lnet_selftest_exit+0x8d/0x8d:
>> 						lnet_selftest_init at drivers/staging/lustre/lnet/selftest/module.c:90
>
>Are you running lnet selftest ?

Perhaps yes -- it's randconfig boot test and the .config does include
CONFIG_LNET_SELFTEST:

        CONFIG_LNET=y
        CONFIG_LNET_MAX_PAYLOAD=1048576
==>     CONFIG_LNET_SELFTEST=y
        CONFIG_LNET_XPRT_IB=y

>Is this a UMP setup?

Yes, .config has:

        # CONFIG_SMP is not set

>The reason I ask is that their is a SMP handling bug in lnet
>selftest. If you look at the mailing list I pushed a SMP patch
>series. Can you try that series and tell me if it works for you.

So it looks your fixup patch is not for this case? Anyway the
reproduce-* script attached in the previous email should be fairly
straightforward to try out for reproducing the bug.

Thanks,
Fengguang
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
