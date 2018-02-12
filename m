Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226WuYfupTUuE4dA+hBKZB2odJIL9ekVMntjJFpTLuQj13PX9X5APyGj63ZyWKQ+HlzWOw/o
ARC-Seal: i=1; a=rsa-sha256; t=1518471070; cv=none;
        d=google.com; s=arc-20160816;
        b=h5wAmC3a2eKz4e5aUTKiQS4wtm+dr4Nn5x+qEXvjHqQXTlvLU+yFcQh0bjR+WSWO7P
         UpThuYE+Axj5Nj2vOgO7IQSVPrIMure+I+xa1auj8ZH5Uj5WBiBVbK/YfXc3QxvT6Yjk
         nPwPyVN/qvnQzJJxVuy5pX9uSV/Q9w9rpd6VxbjKdzSqvO1C8SRDO028O5i4qwnqluQd
         Wp+wbR1oy8skMGqxQkn5i0a332RJf45cM58mF15HP2PMiQ6ioEBXoQ5m/JrUJ24nBMid
         ibEkCPmUs+pUnf12WZeiSzlXCKovz6qSE5TedhQPtsPNXpYeORSLPqrsOBpd9Hwg0V1A
         ncbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=OCq8Dg9YUGMpf+KI1l5zCB5iD9yV6gs4TGYE2TE+gxc=;
        b=jfvAyBowmOVxYzmdieUy1/2+nHzWQF3BP48zXS1anueD0yGp3wdv61I8F408zgLyrZ
         b7P3vQu/Amuz2I2/HRPU7JQBW/+SR8la6xoUP+1gpzXjzgHmjKfDya5ZGmPDaNc9Vu9/
         Rh0fAip+v6rNoZug7b4MLVyHuE1hO8L0BRNhBS+bke3USRBl4XgIpmuI50i2ZVu+NouV
         4ZP5b2Hx36BEU7t/KYltgqJ0DLoUt+kCFdc6Fqa8U52MevzsOm4HnoU4AphzubQmM0f9
         FoWgCgmZ/aRW291MAIcQoZejORrhwy4AKZFRYioYFIgsT/XCcdRtTZXhSLKRnH7PKKTQ
         ApfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>, Al Viro <viro@ZenIV.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 08:30:47 +1100
Subject: [PATCH 0/5] RESEND dcache/namei fixes for lustre
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847081541.26699.3911837371411314092.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592232321156831100?=
X-GMAIL-MSGID: =?utf-8?q?1592232321156831100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,
 this is a resend of some patches I send in August 2017.
 They fix a couple of little bugs in the namei-related code
 and clean up other bits.
 Only change is that one patch was dropped as other dcache changes
 made it irrelevant.

 There will be compiler warnings about a 'const' until a patch that I
 sent to Al Viro - and which he acknowledged - lands in the tree.

Thanks,
NeilBrown


---

NeilBrown (5):
      staging: lustre: llite: handle DCACHE_PAR_LOOKUP in ll_dcompare
      staging: lustre: llite: use d_splice_alias for directories.
      staging: lustre: llite: remove directory-specific code from ll_find_alias()
      staging: lluste: llite: simplify ll_find_alias()
      staging: lustre: llite: refine ll_find_alias based on d_exact_alias


 drivers/staging/lustre/lustre/llite/dcache.c |   10 ++++
 drivers/staging/lustre/lustre/llite/namei.c  |   60 +++++++++++++-------------
 2 files changed, 39 insertions(+), 31 deletions(-)

--
Signature
