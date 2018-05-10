Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZo69JOCw1xK+dVpca5TlKil0Qladd0p6niNx9n6360x9GyuNRhmkodTtzt91W/4246HXjeZ
ARC-Seal: i=1; a=rsa-sha256; t=1525978514; cv=none;
        d=google.com; s=arc-20160816;
        b=UbM5/cUk1tA7K5nM2a/0wsO/4NTs53NPpeGr+hhbOBoANiPkSL7CNg0k32MJ2bnMbw
         cXGQoFRydM6uZIo9B8ruGLQ5q14JZHR4XUpsqbmKrjoRhhcHaO7nbRa1eGinCsxACBHs
         cz4CZ4xinCXit4oF41Ma0PDCqjTe36xSgMRjeNg+JzfawGAzjuZJRu3ov4vNq5Zv7+zz
         VBegvhyIAr8vZ/JfrT0xKcFeU/nHwRt0qP8YSvCFRDvA3skd1fAkh1xKd405hNTUmoSH
         qnZO/jMIoNOdeUh+OTFiZMPg8IoYmWdlTtt+hkrX+Xwr3X6sKDm7cmlt2jjlWRMaKpAs
         D8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=wXe7DjIs+qBNolMI04JiCYNt2FbQYSrAtePAftBN80Q=;
        b=cz1W1Grye68us7YBmrTrhFsoutAHlulp3LoeTUXz/09eO9am8suoLB/Q/qvR33CgVC
         Kz9yb7axRzhx0gCmrvwV4Vss3Ru8CP8jSnZl3mRGdFIBKbNClVXZwPFqrn9MDbFLVFy1
         jJzhXXXj1ZfqmwNFB2AwGWKZlGYWm0KyTfbeNclIDcewOoSDyv1ifICGOO9vylpRMdLf
         LaF7C3+Tw31vN+8PqUsricfofRPUobaT5aO91z9VxWNsMUe5/CRJKv0Qe5lDrACvVp5n
         6ORxz7YE0g1RmI8z+oESK1c9V3E0pa84RZnzKde32Q6v1iU+Ags0OIvTdIQNlP1AVvt5
         Z2vg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kPh+Fjq3;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kPh+Fjq3;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	willy@infradead.org,
	geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v3 0/2] mm: PAGE_KERNEL_* fallbacks
Date: Thu, 10 May 2018 11:55:05 -0700
Message-Id: <20180510185507.2439-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600039618816101704?=
X-GMAIL-MSGID: =?utf-8?q?1600104446836434472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the 3rd iteration for moving PAGE_KERNEL_* fallback
definitions into asm-generic headers. Greg asked for a Changelog
for patch iteration changes, its below.

All these patches have been tested by 0-day.

Questions, and specially flames are greatly appreciated.

v3:

Removed documentation effort to keep tabs on which architectures
currently don't defint the respective PAGE_* flags. Keeping tabs
on this is just not worth it.

Ran a spell checker on all patches :)

v2:

I added a patch for PAGE_KERNEL_EXEC as suggested by Matthew Wilcox.

v1:

I sent out a patch just for dealing witht he fallback mechanism for
PAGE_KERNEL_RO.

Luis R. Rodriguez (2):
  mm: provide a fallback for PAGE_KERNEL_RO for architectures
  mm: provide a fallback for PAGE_KERNEL_EXEC for architectures

 drivers/base/firmware_loader/fallback.c |  5 -----
 include/asm-generic/pgtable.h           | 18 ++++++++++++++++++
 mm/nommu.c                              |  4 ----
 mm/vmalloc.c                            |  4 ----
 4 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.17.0
