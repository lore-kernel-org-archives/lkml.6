Return-Path: <mrybczyn@kalray.eu>
X-Cyrus-Session-Id: sloti22d1t05-3610541-1517490286-2-6798607146905614746
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, SPF_PASS -0.001, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='92.103.151.219', Host='zimbra1.kalray.eu', Country='FR',
  FromHeader='eu', MailFrom='eu', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: mrybczyn@kalray.eu
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517490285; b=SmlxWwdfLGnMWsRy0h1iulE05X7BXDR6G3Rp3I+o3UdnWaf
    mtU/i3yr0zXTga7mvnYnllra8S2cn3V3u/ykjL8R0MQLdccauYKQALrgP73F0zzx
    Z717ZBUDtdY5pMPPua5cVXg6L/ZsItIKIFY7EjCgMCLyDlyUaeZmTrp+FIj6JHBZ
    DhCl03OGGUEmpf827puUSmLBlscNsBawDuWuuLZZlOOjzYAZmHj6So+q+/7yZ6d8
    S3ONT/FGObBX0ixdaf+iUXk4ycu/iQXYaZJX8pGogruCRDVbyr3EY7MW8TrtQe6y
    TGNLNLQcV1m9V0nhyqtuZA+Jv61zEYK4kgu7U4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding; s=arctest; t=1517490285; bh=ODVdWpeD
    as7VJwnJc3pF9tmjUUzhh3SM4J5+ekbympQ=; b=L2ch/xkFi5TX/1b1iD6uJhA7
    /l9QK0I5CT3uUFXBq7OxwNJtYw0T2IcT9dpFWQxEFs7N6Vle8Msp+DCmAjMnJS6/
    vGL/exJdkfKlKMCp5PBwIAWHEr41yOupWKOTRBqdxT2fNdD8NZBJ1lJ7G5Wfr0Kn
    ubb51pquhZAGYaPO9ThKQvWmkbAruEJctlcndrv29rMQgBil+SLqhLvkgNpFORw8
    o2eqP31lwlTNJbA/RqjnPLl10bDMkgG3Lo/rjj2FLSR45dGOa3zD8OqGOSowRjMC
    +tKY/rKF5te1dQ/AO32VwxOwEMNPRpxfx638tWJYTiauSz3HE5/XYcs1sdbbrQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kalray.eu header.i=@kalray.eu header.b=cWqEq/3T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=32AE1B44-9502-11E5-BA35-3734643DEF29;
    dmarc=pass (p=quarantine,d=none) header.from=kalray.eu;
    iprev=pass policy.iprev=92.103.151.219 (zimbra1.kalray.eu);
    spf=pass smtp.mailfrom=mrybczyn@kalray.eu smtp.helo=zimbra1.kalray.eu;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=zimbra1.kalray.eu x-ptr-lookup=zimbra1.kalray.eu;
    x-return-mx=pass smtp.domain=kalray.eu smtp.result=pass smtp_is_org_domain=yes header.domain=kalray.eu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kalray.eu header.i=@kalray.eu header.b=cWqEq/3T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=32AE1B44-9502-11E5-BA35-3734643DEF29;
    dmarc=pass (p=quarantine,d=none) header.from=kalray.eu;
    iprev=pass policy.iprev=92.103.151.219 (zimbra1.kalray.eu);
    spf=pass smtp.mailfrom=mrybczyn@kalray.eu smtp.helo=zimbra1.kalray.eu;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=zimbra1.kalray.eu x-ptr-lookup=zimbra1.kalray.eu;
    x-return-mx=pass smtp.domain=kalray.eu smtp.result=pass smtp_is_org_domain=yes header.domain=kalray.eu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
DKIM-Filter: OpenDKIM Filter v2.9.2 zimbra1.kalray.eu F33542800E2
Date: Thu, 1 Feb 2018 14:04:40 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Greg KH <greg@kroah.com>
Cc: matanb@mellanox.com, leonro@mellanox.com, saeedm@mellanox.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sean hefty <sean.hefty@intel.com>,
	hal rosenstock <hal.rosenstock@gmail.com>, stable@vger.kernel.org
Message-ID: <1067971124.17656949.1517490280812.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20180201082116.GG15896@kroah.com>
References: <622645763.11304810.1517303571694.JavaMail.zimbra@kalray.eu> <20180201082116.GG15896@kroah.com>
Subject: Re: Backport Mellanox mlx5 patches to stable 4.9.y
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.201]
X-Mailer: Zimbra 8.6.0_GA_1182 (ZimbraWebClient - FF53 (Linux)/8.6.0_GA_1182)
Thread-Topic: Backport Mellanox mlx5 patches to stable 4.9.y
Thread-Index: MTEIghlBLvci5QntM9ZwNzyqHfvwcg==
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- Mail original -----
> On Tue, Jan 30, 2018 at 10:12:51AM +0100, Marta Rybczynska wrote:
>> Hello Mellanox maintainers,
>> I'd like to ask you to OK backporting two patches in mlx5 driver to 4.9 stable
>> tree (they're in master for some time already).
>> 
>> We have multiple deployment in 4.9 that are running into the bug fixed by those
>> patches. We're deploying patched kernels and the issue disappears.
>> 
>> The patches are:
>> 1410a90ae449061b7e1ae19d275148f36948801b net/mlx5: Define interface bits for
>> fencing UMR wqe
>> 6e8484c5cf07c7ee632587e98c1a12d319dacb7c RDMA/mlx5: set UMR wqe fence according
>> to HCA cap
> 
> Looks good, now queued up, thanks.
> 
> greg k-h

Thanks Greg!

Marta
