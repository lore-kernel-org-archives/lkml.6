Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-180677-1521513269-2-10637180639861872216
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521513268; b=LdrEj/nRO7TvAo4RGuAxA4DOHyYLOGqtSRP+CgD4PyD02SP
    rDw+mLSi9E0wRvzPBljTKhWTSqZ4vdKOQ0hB1gYT5wDqcEn2sLwMoLJm6eqnSQSm
    /GqzyzM0+Z2k1L4PdPSa8adSCNffNebn+BH7GoeylIPrWbkFWZeNfvr7mGb5WzFH
    8xu0DKppWFBY5A9uKM8Xht0yu/m4SJEVb/lxw9zUNF9WrvoJmePI0l2EaDJg9q3T
    25jiTtLOO5Mm0Uo0ybg0fqzwYH+KVIXF8qyHwHmxuidbsum9onQ5LKeDcF/LcMmh
    20w1PkddumWKJnR3BuvkS7dFkK/bCQZLsDYpOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1521513268; bh=cb+YVFEJuMZs5nEfT70XLrcg8ml
    0a0aSEUJqsKcD9Hk=; b=qNAFQtthwK747hKzcqbcaPSHUfmeD+rJSj0/zInxkoC
    25/kaLWRGiU2p+xWMfd0gvksxxVyOdfS6ImScciyz3HNFhNysu9csyKPauc8I+sK
    AIjjjHJZ4ayYOfkhWv8b4xXCuKL8Zcm6UOV6I0geLw0QRbbCT7yOtMbxYuLiZS+/
    pmkpufBTodml80cK4UZ8uDO2pkDvGKWcwTMClKDDcJXhmq5BF/Qj9xr1xnAAtZRU
    yHWI7nY50L4rmXVl3ivIwpCYevt2lppp8PqfoIKH8dh1M+/5LNlCWvX5aj+u9dzF
    0f86tN2KmFT4wS8pGkaTZiXMHlxw+LMn7quaQ+xe/Pg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvfffujghfkfggphejjfegudeftdgtvghssehmtderredttddtnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesshhushgvrdgtohhmqeenucffohhmrghinheptghouggvmhhonhhkvgihrdhorhhgrdhukhdpkhgvrhhnvghlrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeeipdduleehrddufeehrddvvddtrddvheegnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeeipdhhvghlohepshhilhhvvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeiiedujecuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvfffujghfkfggphejjfegudeftdgtvghssehmtderredttddtnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesshhushgvrdgtohhmqeenucffohhmrghinheptghouggvmhhonhhkvgihrdhorhhgrdhukhdpkhgvrhhnvghlrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeeipdduleehrddufeehrddvvddtrddvheegnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeeipdhhvghlohepshhilhhvvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeiiedujecuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: kernel test robot <fengguang.wu@intel.com>
Date: Tue, 20 Mar 2018 13:34:09 +1100
Subject: Re: [staging]  184ecc5ceb: BUG:unable_to_handle_kernel
In-Reply-To: <20180319091931.gt6ijdw7ahkbtvrq@inn>
References: <20180319091931.gt6ijdw7ahkbtvrq@inn>
Message-ID: <87h8pba31a.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkp@01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============8396241098239136806=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============8396241098239136806==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Mon, Mar 19 2018, kernel test robot wrote:

> FYI, we noticed the following commit (built with gcc-6):
>
> commit: 184ecc5ceb379b43b29fc373f497fca88c73ad38 ("staging: lustre: allow monolithic builds")
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/staging.git staging-testing
>
> in testcase: trinity
> with following parameters:
>
> 	runtime: 300s
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-i386 -enable-kvm -smp 2 -m 320M
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +------------------------------------------+------------+------------+
> |                                          | 26f7a294e5 | 184ecc5ceb |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 14         | 4          |
> | boot_failures                            | 0          | 12         |
> | BUG:unable_to_handle_kernel              | 0          | 12         |
> | Oops:#[##]                               | 0          | 12         |
> | EIP:cfs_cpt_spread_node                  | 0          | 12         |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 12         |
> +------------------------------------------+------------+------------+
>
>
>
> [  123.548190] BUG: unable to handle kernel NULL pointer dereference at 00000008
> [  123.551023] IP: cfs_cpt_spread_node+0x31/0x100

Thanks.
This happens when both USERIO and LNET are built into the kernel
drivers/staging/lustre/TODO says
  LNET_MINOR conflicts with USERIO_MINOR

I'll add a Kconfig rule preventing them from being built together until
this is resolved properly.
I'll also lok into making the module init routine more robust.

Thanks,

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqwcyEACgkQOeye3VZi
gbkyUQ//XbubyfP18/VpiEzZShQ4DgLWpoEgm8OZLrwggck9ds+vGYwdrwH35Mty
hl11ec+ukQT+k5b3VKs/+ciS1K2qsfDRUpzbcTpGLEQFvtuVqoJkQz3IPCQuz2vG
x4vLWV7fBuAeJSkg3AIBa/VSUmkBp/Q1qdHEzN8Cjh4sB/Mq77xFhw69yioACh1C
x0IveurxurNlW5IiJbC3PW4w3S9BT+gIcYKwp1Gb++J2CdGos5p6+ZLZhmK1LzEp
m0KeA/fnxWCj9Mo8Z8N2O33LE8aB0vMvnW/aAfcfhgiLVNMGk5DhmKgxsfEu7k8v
2TFgVTF67emaFFSFSQA152srWT3u/C1Ar/YWyAg8XvEN7xP4PTHiTBj3Od8Cztct
6mRQUSKVEzKNi/Us8epsYvc7VNBIT5mL36z1HDjwkyQjkUKSGxNQU7EBzKEtp8aS
5PRsp0RuYuFFsIsNEdqEjkEkFcVz570C1PhypX8Qo4mlG6azVOb7TlQ/Zk6ilCYG
iZbbvJySBvrTbWQZdbMtqpeeJ0nuksN7S87eXLvOMPFztoSXh73HVuObU5n5TVOu
BHFggfdbI2Hzpa6d8H5dYXbTY7iBj80ncCMlSa212KsyFTpVi/sMbUtZwJi5tJWM
qQDR0OTODQu5f/z06V0t0UZvoSd6JHOHFoSJ8949TYJYNH9sIoI=
=UnnV
-----END PGP SIGNATURE-----
--=-=-=--

--===============8396241098239136806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============8396241098239136806==--
