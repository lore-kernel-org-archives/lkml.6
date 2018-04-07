Return-Path: <kernel-hardening-return-12876-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+mo7shNvjIr6c8nVRrIfFfGzev6QeffBW3PLzpjw3XxYpjbu2KnMs+fHJVkwYgI8MnuiRv
ARC-Seal: i=1; a=rsa-sha256; t=1523126357; cv=none;
        d=google.com; s=arc-20160816;
        b=ALV7kPvzE5rnV2GAbzcu3fiBSSykd2MRY8PbMxcC3Wq4B/LD6up7XEhwkLnzIUaD/S
         0vKbpd7cpZCYS+erV9zl33nUTwjhUvrRwRfwZMT9dMNzb5RQ1Vs11f1ase6RlPF+nT2A
         WmnbWvsWO4ogewbPz7U5WaQhY9YK0s+CrDSUKaBF0fhe3ASI8BLpfRsPkan1keL2aUL6
         kTD0ehdxwC+Ph3FtwgW6Up3YAU68sa6/+cvnuyI2knotq5xtsPRSIdxtqEY+Nf3gPxur
         vtjBpYoHyyMwrwMoJ+zew+vQhxibIU6nQ59HJiiYvF0QviIZJFl3UhFTYd7QC/4H96hi
         PtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Eaxm2NIVsuvWf15YbboTg1KrK1/hLMB61bFRYaEO5uQ=;
        b=HFXCM8o1g3Mpri1F4aTwYdtomxVsxH5Qi6krC9kiyM7wdXAtrjR2z/QziJPCJxgpba
         gmRGBT4UhuRU5WaaGSp1LkwSXTwflwGv9WMUl5sSVqFltPp+JaVU9AXSXLxfTOlwW0bl
         ryQdGBC/9VshPryi98fr2A2lZRXi5AzsuYFPH9RSI5JDyDyCLjVseloFy6zfH1MCn2ZD
         YaKUg4YDDyo3qircNDeinMzC1mGtt9YiMM5Pi6lLKgSg5BoXnEcdoF+IiuJAib+vUJo7
         xUQ0JsNbKo7WGa3yket6dTcUj2vaUkwPoxT+Bd5MHnc2O6uFh9m6pYhyThWJrGkwmM43
         rhaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=czmm17fE;
       spf=pass (google.com: domain of kernel-hardening-return-12876-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12876-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=czmm17fE;
       spf=pass (google.com: domain of kernel-hardening-return-12876-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12876-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: [PATCH 0/6] Remove several VLAs in the crypto subsystem
Date: Sat,  7 Apr 2018 20:38:17 +0200
Message-Id: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113743875859229?=
X-GMAIL-MSGID: =?utf-8?q?1597113743875859229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As suggested by Laura Abbott[2], I'm resending my patch with
MAX_BLOCKSIZE and MAX_ALIGNMASK defined in an header, so they
can be used in other places.
I take this opportuinuty to deal with some other VLAs not
handled in the old patch.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
[2] http://lkml.kernel.org/r/4e536889-439a-49e6-dd95-2d4286913202@redhat.com

Salvatore Mesoraca (6):
  crypto: api - laying macros for statically allocated buffers
  crypto: ctr - avoid VLA use
  crypto: api - avoid VLA use
  crypto: pcbc - avoid VLA use
  crypto: cts - avoid VLA use
  crypto: cfb - avoid VLA use

 crypto/cfb.c      | 14 ++++++++++----
 crypto/cipher.c   |  7 ++++++-
 crypto/ctr.c      | 13 +++++++++++--
 crypto/cts.c      |  8 ++++++--
 crypto/internal.h |  8 ++++++++
 crypto/pcbc.c     |  9 +++++++--
 6 files changed, 48 insertions(+), 11 deletions(-)

-- 
1.9.1
