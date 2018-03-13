Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtaJsLgKOlQg1vKwM6vnZBeOHzC1QNvUST8830HJ38sq0d72R/RRNZ1doXiHgbtCoSEzpup
ARC-Seal: i=1; a=rsa-sha256; t=1520955538; cv=none;
        d=google.com; s=arc-20160816;
        b=flLSuRsctHr98dNizHhd5jh6yPQvO2JFHxVuJEKEn+mG0kzDY+wi9C3867ihq1eWEU
         9cNiAV1RVDmEvtovDYCD7s2hq2BMiV61q7bWrGnywCQH5FWbFSXiF6pA+Kr5gnE4iTA5
         VTeGoJeq8KSpXFv6ADnxUj5rgSlLOjI5BNplShA96umoyvLkW1F7tzW9mi34yjVi5paU
         bMISjGAIuPpKp1w0kIMppGo+F/m4ZZN1MNk+BulNKSbbbyn81+741XLJnb5fEbw2Z0Ek
         IRRik2wnvEQNZ4tH1UxIYyLt2IaHD5kDOrHSnr1aH0RlNKNCeRhEyJuE6j1d+QZN+vlZ
         sqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5ir55J50kGHFWuh9PN+Us7otKxoAcDjLwQinzYSxlnY=;
        b=xrBWXMqwNrcJyrw3XvuR+jyEC8KreuQSBQw3lrox7RqtKGbdu7CIOT35DGXMm1mG0/
         SeyFyUie00o9WwE4kG7p8FtHXbEgcFnqZsurMSfU6qnqwq7Kw2Mq++Px+nvPcr7tpDqZ
         C8M57M10nCkuVhMjeh5nPc36+PDXZblVXcf9NLAPX5tLEDx6ye12FOUf2v2UmQCSlSa8
         P0GvAYC09Wfg1K1WGbOAMrVq94EoXISYpCm4O1hAsq9FTL0vGqbp7P7B8tIQYGXkUz1s
         mkcn24bFYzQj2qRfG8Owo6zKlZJEiDMIg7IAEqd0YLBTuxg5GQZGSu2nfZ3lBM7hWEez
         LtyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Vacek <neelx@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Paul Burton <paul.burton@imgtec.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 084/140] mm/memblock.c: hardcode the end_pfn being -1
Date: Tue, 13 Mar 2018 16:24:47 +0100
Message-Id: <20180313152503.820272972@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836963578294574?=
X-GMAIL-MSGID: =?utf-8?q?1594837475110157941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vacek <neelx@redhat.com>

commit 379b03b7fa05f7db521b7732a52692448a3c34fe upstream.

This is just a cleanup.  It aids handling the special end case in the
next commit.

[akpm@linux-foundation.org: make it work against current -linus, not against -mm]
[akpm@linux-foundation.org: make it work against current -linus, not against -mm some more]
Link: http://lkml.kernel.org/r/1ca478d4269125a99bcfb1ca04d7b88ac1aee924.1520011944.git.neelx@redhat.com
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memblock.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1107,7 +1107,7 @@ unsigned long __init_memblock memblock_n
 	struct memblock_type *type = &memblock.memory;
 	unsigned int right = type->cnt;
 	unsigned int mid, left = 0;
-	phys_addr_t addr = PFN_PHYS(pfn + 1);
+	phys_addr_t addr = PFN_PHYS(++pfn);
 
 	do {
 		mid = (right + left) / 2;
@@ -1118,15 +1118,15 @@ unsigned long __init_memblock memblock_n
 				  type->regions[mid].size))
 			left = mid + 1;
 		else {
-			/* addr is within the region, so pfn + 1 is valid */
-			return min(pfn + 1, max_pfn);
+			/* addr is within the region, so pfn is valid */
+			return pfn;
 		}
 	} while (left < right);
 
 	if (right == type->cnt)
-		return max_pfn;
+		return -1UL;
 	else
-		return min(PHYS_PFN(type->regions[right].base), max_pfn);
+		return PHYS_PFN(type->regions[right].base);
 }
 
 /**
