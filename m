Return-Path: <SRS0=uqI5=HD=gmail.com=adobriyan@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2748774-1523735971-2-15290912633781930016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=uqI5=HD=gmail.com=adobriyan@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523735970; b=d8r9II7IdRllYkxVDjo0Q4sJQRw4MoXzqqv36h3TTrn82S1pn2
    91eRllhHPi4RD1z9ifSt8kkWegNEhUZVoHKbJEJdB5UTcbdR0zsakXFYyUi+uSad
    OKq/jrQpnsggeYIE9kPpOgLceYmX+tYqn2XXQebk8MNqMHT/q/qccvmHHNpjdMIP
    tQSAL6DTJcj0Ix/T33FoutQT1y1Zjs/6mNl4Uc4se54n20UOG8GU/5EpNEpCwqLd
    9UC7BS3RurGlcf3wvPORHtJIijuAweejEaZ0v7eFLfwtw8TJ+wO1ye8OLCNVeIzU
    hCV3exjg6pCUiDOmQBjDgQFyGSutHXLwWpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=fm2; t=1523735970; bh=SQlzpE/mjZ9N
    zyyJq1tHa9K9p5+hKgDUPKFPaaGcxHQ=; b=ldwNFi3sz/cxX5j3QXpGOsbu8631
    me2xpYlaxV+RVhbWD1t6szn7Z8jnlKMWdATJKdr+/Ekm0keX+jxsjnBLvUQWJ1jq
    gGvMGiizgYXouZXWkPGeaJ3aqddPdKXTpXw70cyLxKmwdFtvWyyiXPTdrLPeLeES
    FmNxIzzWemHRX2iZ6/PgDMwV8EyageV8sFft3eBl8k8Hyk2rc8qI2XJbMIlEaXdj
    rwZNdWa9rhkQt+tHuIhs1Is9qgYjX0eMbl5r+gNyZlXcplIkagxAz9omrIMg5INy
    dRXDza0Ttp1+X1XF17UFty76vRu/6nEXQlslwo+OdBJTWGakzhj+Zmzd4A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TT8X3DWh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=uqI5=HD=gmail.com=adobriyan@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DlTPPDUH;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TT8X3DWh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=uqI5=HD=gmail.com=adobriyan@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DlTPPDUH;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBBJdrWqgaJaxcTq61ScePLT/C2iNhjp0msvV2r4Rc6xUkBpICDdh5sDqBJHuLimDYN/4hri5HSeMGunbGgiamhnaV5wpxVT876dWASPtBS7ROFL1mS4
    MF4V3qDDCFvJTmxq7h+nrgMreUkbygdbHfaczZvAQoczbX/Vx/VHCHCbKT8J7bDFFri13WWUH7sDpoHEv2Bp0ebIHud5/5lgkWg=
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=aLjZf_mOksQA:10 a=Kd1tUaAdevIA:10 a=d-NkeQXBJoyQO3lm17wA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E652077B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=adobriyan@gmail.com
X-Google-Smtp-Source: AIpwx494iosWywTGrPxbFaHIRmpWAXY62AvTldcTAq8mIpnrxgBdqGFdTtvPbqWD9VB0sRXcky6rug==
Date: Sat, 14 Apr 2018 22:59:21 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org, tytso@mit.edu, kvm@vger.kernel.org
Cc: security@kernel.org
Subject: repeatable boot randomness inside KVM guest
Message-ID: <20180414195921.GA10437@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SLAB allocators got CONFIG_SLAB_FREELIST_RANDOM option which randomizes
allocation pattern inside a slab:


	#ifdef CONFIG_SLAB_FREELIST_RANDOM
	/* Pre-initialize the random sequence cache */
	static int init_cache_random_seq(struct kmem_cache *s)
	{
		...

Then I printed actual random sequences for each kmem cache.
Turned out they were all the same for most of the caches and
they didn't vary across guest reboots.

	int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count, gfp_t gfp)
	{
		...
		/* Get best entropy at this stage of boot */
	        prandom_seed_state(&state, get_random_long());

Then I searched internet and turned out KVM can pass randomness via
virtio-rng or something. So I linked /dev/urandom.

And it didn't help!

The only way to get randomness for SLAB is to enable RDRAND inside guest.

Is it KVM bug?

For the record I'm using qemu 2.11.1-r2 and whatever F27 ships now.
