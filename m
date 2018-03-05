Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AG47ELtBdlidpWrS0A/7Edla112mEPbQuJqrEEHlRVV68H+vTODaM63SVDNUr3wt1s3SeSQNj0rB
ARC-Seal: i=1; a=rsa-sha256; t=1520222316; cv=none;
        d=google.com; s=arc-20160816;
        b=rGb1NW/TxZGbnOxmb99Nb/9zn5Nv2tc45131tHs7f930+bHCpFlz/qWS/2EpQjurNx
         HARr4XbvjbaOYuoAgHWwqKt8KX4KI2NLd3lfhu3GA/QEMdyGQgt2EloDpM1iI+zkGmos
         y0tl4CpVnUsCmaQr+cHBVgH13ZQWd0vxquaUMx07m3v6rSpZf/73BurTkCzLKTxQbOh9
         SNOcVWiONgualNbIkSj9nHYObwNpWvSEmc8QHdvsxpqBs33eXbqYL1AbPii8gUHZPj4+
         AqLJWhm5evIhc6M5irCFjNYezTsy0Li5e3xpg1dJdHJwZ67QUcY1BoC4a5Ax6U2aKk/I
         gYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=CX5vrreyekJdxIpHbAPwpJ/JBgAJH2DR1lY5WzHrOMg=;
        b=Kx3n1D7ZoNFw3Cd34zZYsGXPtETp3o5WemSvbs0pDaTiidQ0lT+NBKG5+QKUbVnqkB
         vLaOuMzt91caWbpJn1txNNouneJyWwbw6OMPzF6bgDwKjwsU6VoHV6zNDQDhPHdstgoz
         oqGtF9rQqICE9OU8LtzCKh9ZoSu6Vc7NSlE/rKU3vBy4v3IYAmgSSWXExjWrqow+kEp5
         jviudHxBcoHeHG0ehlgQj5V/eIX0cP4OO68g0xahh6H4dubMl7nDS/bXq1pVwgeaFPPF
         oo445N0D6iPfGfPc7p1r4IYNxNX8iWHzKmCCAyy2DoXYUocK9rCauG9rjZ4jzvGgoeTa
         gaMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=qHRyPvwL;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=H0ptjCvM;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=qHRyPvwL;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=H0ptjCvM;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:asCcWlaGeq024xNnl7kVgNcvje-UOGhB_HEwm38I4_Ah8hXXT5Q7mA>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Joe Perches <joe@perches.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: 
Date: Mon,  5 Mar 2018 14:58:19 +1100
Message-Id: <1520222301-11874-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594068635369112589?=
X-GMAIL-MSGID: =?utf-8?q?1594068635369112589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Subject: [PATCH 0/2] Resolve Co-Developed-by issues

Recently tag Co-Developed-by was added (via a patch to
Documention/process/5.Posting.rst).

see https://lkml.org/lkml/2017/11/16/257

There has already been some discontent expressed over this tag.

A recent patch using the tag generated this response from  akmp (on LKML)

	I prefer not to include tags which aren't listed in
	Documentation/process/submitting-patches.rst, but I now see that
	some bright spark added Co-Developed-by: to
	Documentation/process/5.Posting.rst, so the two files are a)
	duplicative and b) out of sync

Also, there has been comment over the use of the second capitalized
character 'D'.

This patch set attempts to either resolve this issue or bury it for
good. 

May the bike shedding begin :)

Joe Perches (1):
  checkpatch: add check for tag Co-Developed-by

Tobin C. Harding (1):
  docs: add Co-Developed-by docs

 Documentation/process/submitting-patches.rst |  9 ++++-
 scripts/checkpatch.pl                        | 58 +++++++++++++++++-----------
 2 files changed, 42 insertions(+), 25 deletions(-)

-- 
2.7.4
