Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-494466-1524059975-2-15922603863478782283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524059975; b=lX6G4WXvZG2X4jZ8oPbTnRPJbc9VJp2/pWtd203WUZLSb3wQqB
    PTRD0uHJcmSvLJ7/STrd4OaKoYPyUxHJu59LzLCZsMbdd6ksk7uCxEWLIKTRx2Dj
    Gw0ToWybBFWXpJYZxPzITzE4zMXOh8+oU1yXbYOpM+spt/BySiuELTVAA+zfFH5Q
    l6/OvFZt/kdq/a7D4dIWBcj5zHHgpLzQWjp7DM8c4Hl6TbjvFMn1EMdsQDkuy1if
    fEDhrPiqLjUFwg30CnFVoyuXTXMWrR92NZlIoqUvlE3prUAGZMgwOym/BDI+9t2g
    IF+L+d8mOK9UgTQ7gno3rLijRixDDBZRSyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524059975; bh=USkun
    M5CF8wnMyP2d8VIe3aU/n3ok1WRlXnQWMfwfcU=; b=WW0zeH+MH99CH+g35RI4G
    KIbU60CAm/ksm1g87ccCT0dZyGZsdGKU5Mm9yURgAFDwnM0v9ZcC8ecsOkFol4JD
    5VbnLI0lQ+p3uprFpapv7xl+gzrEkKo/2sHlLsfib2JpjlDbu7Ak2vRszgprqL2M
    ux82r/rN1pZjt/pFwB83q22v8NuMrt2TRYtH56spn7ubA6dwFGezWqi3j/Ca+I6f
    0PAtZFn2juTUu+TYDRCtlx+BUqmladbp99FrqgUyMfYsLryPCOzBtfIZjBR0NK0u
    N/ZZPB/ctO9KszgHDnOpJ1BNxu3+AL+z7b0w8VQP1G607SE7bhBFlP7W+96SRaIA
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=THeTJTOE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=THeTJTOE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJOyaFj+IOAih+NRiFwVD4aKcM1jsOfhOOqF8prUBsCzPpvT6yere1QuvbAAGa1O7ji3df1QGH1wKmAx52zJWEglfSwdYrTQXWC1hsOxggOkx9Ne/SUK
    ss/wG3f14lo4/ub4MySPev4W93V/JkAT9n6qWhtY35NJfCS9044QC0VVMczKTD5929OppOHzo9iO86GWI0p+0JRjQVU4/cdgu8Vf60SNfM67jst6cSnW0ZK9
    kCPH5DdTS3WwAmpG/QwxKQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=URQ5On98gdO8jRahR2MA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....0 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Wed, 18 Apr 2018 14:59:15 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [cfs_trace_lock_tcd] BUG: unable to handle kernel NULL pointer
 dereference at 00000050
In-Reply-To: <20180418133831.uef7d77ejdyjtxgh@wfg-t540p.sh.intel.com>
Message-ID: <alpine.LFD.2.21.1804181456590.5599@casper.infradead.org>
References: <20180418133831.uef7d77ejdyjtxgh@wfg-t540p.sh.intel.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180418_145916_045102_35DAD21E 
X-CRM114-Status: UNSURE (   8.88  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Hello,
> 
> FYI this happens in mainline kernel 4.17.0-rc1.
> It looks like a new regression.
> 
> [    7.587002]  lnet_selftest_init+0x2c4/0x5d9:
> 						lnet_selftest_init at drivers/staging/lustre/lnet/selftest/module.c:134
> [    7.587002]  ? lnet_selftest_exit+0x8d/0x8d:
> 						lnet_selftest_init at drivers/staging/lustre/lnet/selftest/module.c:90

Are you running lnet selftest ? Is this a UMP setup? The reason I ask is
that their is a SMP handling bug in lnet selftest. If you look at the
mailing list I pushed a SMP patch series. Can you try that series and
tell me if it works for you. Thanks
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
