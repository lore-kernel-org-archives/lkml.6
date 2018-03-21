Return-Path: <maninder1.s@samsung.com>
X-Google-Smtp-Source: AG47ELvbSYavWW2cXcwLB/XBMldpmGmVQ26A4sVCVKqSVZ/97t6ssYX3VnvnVugbIm8DQ3XGfrmU
ARC-Seal: i=1; a=rsa-sha256; t=1521607102; cv=none;
        d=google.com; s=arc-20160816;
        b=i1ekHiGM4UPiZmKBPVvKtXb1vxakUocy7uxihq3CJw1oAuVY94hUuuyoePAXCOHCo5
         w5lHIqpnO76iSmchxUKXFwsrEqxL8LrWNeHY9VPzYnVMIe60246xN3445kHpJxJHTvw/
         ylXeYvJScVuehGhfp1v9UKUqH/GEtuKgQIVceq7cROqKHxoSNgLuNFYT+BQ7vDPMP1z+
         QTgIRJ282Chjm2Q0LbbBW1jMESpt3y7HQ0sCZASaTjH9+gRO/MhsqeQzVA6VIakYEMAz
         uJTVgGg4K1e5a/c6RsVxBT/UmMW3erdbVuGPtRh51i7UzIsqr5gIarkDBnmUcXtG+/ZF
         EwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=oSwT8cMfLLqy6Q7zLCA9YdgYcGnTD3QarsanydAlFPY=;
        b=TU+ZKAWPvnyXhzq1wuvTVky1ucOxeJkk+qapVNIOyQpWP00rGCy52vScm6C+qTA9Bl
         0vkjXGHjO9vsNOR/CpN7IhqBV8JJPy+4w9jMax8GpNqBifxFjgP5supKu8ZRQzbDAgni
         MxazJ47wgw8bBKmqxdubghKVq8b+PN7UzNVzXmEzUEO5iAHfOGVZs/9chl5r/qrLxlWM
         LrS3c1SqV96RBFVFpfTYc3TDoFSd42rKb5dAVq1UBzB0Rz//WDOT6T814Frlvo80onwV
         C8BWTvAzLePlkGx0BjORdbzEsjLtG9fnxk3DmzD0zOAPpX82I9UiHtjITzmXhQ+oWCib
         zwtg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=okiOoOsU;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=okiOoOsU;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180321043820epoutp023bfdb4714b60049148dbc1ba5929c7a8~d1ZiWZird2258022580epoutp02h
X-AuditID: b6c32a4a-de3ff70000001125-4d-5ab1e1bbb1ae
From: Maninder Singh <maninder1.s@samsung.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
	osalvador@techadventures.net, gregkh@linuxfoundation.org,
	ayush.m@samsung.com, guptap@codeaurora.org, vinmenon@codeaurora.org,
	gomonovych@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	a.sahrawat@samsung.com, pankaj.m@samsung.com, Maninder Singh
	<maninder1.s@samsung.com>, Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/1] mm/page_owner: fix recursion bug after changing skip
 entries
Date: Wed, 21 Mar 2018 10:07:23 +0530
Message-Id: <1521607043-34670-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmpu7uhxujDH7P4rO4uDvVYs76NWwW
	V37vZ7c4/PAtq0Xz4vVsFt8ermCzuLxrDpvFvTX/WS0Oz29jsbjf52CxdOs/Jot7b7YyWRw6
	OZfRYnZjH6PF+q0H2B34PS739TJ57Jx1l91j06dJ7B4nZvxm8dg/dw27R9+WVYwe67dcZfE4
	s+AIu8fsvdfZPT5vkgvgikq1yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvM
	TbVVcvEJ0HXLzAH6QkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiqxRtaGikZ2hgrmdkZKRn
	YhprZWQKVJKQmrFt0jm2gq1CFX3XpjA1MD7n62Lk5JAQMJG4dfYESxcjF4eQwG5Gibcrm5kh
	nE+MEo/vbWaCcL4xSny638MO09K7fikjRGIvo8SG5d+YQBJCAl8YJV7PFQOx2QT0JFbt2gM2
	V0TgJqPEnE9nweYyC2xjlNg5azILSJWwQLDEsvOTWEFsFgFVie8H54Gt4BVwlzj0rp8FYp2c
	xMljk1lBmiUEHrNJHFhzCSjBAeS4SDR0pULUCEu8Or4F6jwpic/v9rJB1DczStxZ8ZUZwpkC
	9MTch1BT7SUe3DjKDjKIWUBTYv0ufYiwrcTSc2vASpgF+CR6fz9hgtjFK9HRJgRRoirRcnMD
	K4QtLfH540eoczwkzu2FmuIosWLtV2igxEo82naTdQKj3CyEXQsYGVcxSqYWFOempxabFhjl
	pZbrFSfmFpfmpesl5+duYgSnUS2vHYzLzvkcYhTgYFTi4bUQ2xglxJpYVlyZe4hRgoNZSYT3
	UARQiDclsbIqtSg/vqg0J7X4EKMpMCwnMkuJJucDU3xeSbyhiaWBiZmZuaGBgaWJkjivY6BL
	lJBAemJJanZqakFqEUwfEwenVAPj5NA1k3mE933XzJ7LqnxBgXNWOs/Lv/fK5vx9XZNhGSOn
	os5/qZKZpUj8lYa3/Y3Ty5pKhSaV8vZZ/ecVE7+h3xslW6xV+L/sQ5ZV71KVkKP3DkvIJJz/
	EfJlicPk6vu59z0OtxSypFq1/H9+S+1QHMsk2csz+5Ju33e9/GGpuO6NlAfdU/YosRRnJBpq
	MRcVJwIATb9nLbkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSnO6uhxujDI4dNrW4uDvVYs76NWwW
	V37vZ7c4/PAtq0Xz4vVsFt8ermCzuLxrDpvFvTX/WS0Oz29jsbjf52CxdOs/Jot7b7YyWRw6
	OZfRYnZjH6PF+q0H2B34PS739TJ57Jx1l91j06dJ7B4nZvxm8dg/dw27R9+WVYwe67dcZfE4
	s+AIu8fsvdfZPT5vkgvgiuKySUnNySxLLdK3S+DK2DbpHFvBVqGKvmtTmBoYn/N1MXJySAiY
	SPSuX8rYxcjFISSwm1Hiyq8ZbBAJaYmf/96zQNjCEiv/PWeHKPrEKPH+ywlmkASbgJ7Eql17
	WEASIgKPGSW6Jh0Cq2IW2MMosfvMSUaQKmGBQImuN0fAOlgEVCW+H5zHDmLzCrhLHHrXD7VC
	TuLkscmsExh5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA5kLa0djCdOxB9i
	FOBgVOLhtRDbGCXEmlhWXJl7iFGCg1lJhPdQBFCINyWxsiq1KD++qDQntfgQozQHi5I4r3z+
	sUghgfTEktTs1NSC1CKYLBMHp1QDY4+s2JGMxz4/605/nV7dmxB/MJ6r+td1ubiDH9oKmO9z
	nTPeELz75gvDrRH1v5VW1fx22vVsUvVut6+87AIzV8ybKP/4slzE5cUrzG77+hoz2/5ZULt9
	l+xCg9Wzp/WfOmqW+llgukHlpJaeZdGTLI/l7d68LibzPtAUvY27fBVOal78u2pDjBJLcUai
	oRZzUXEiAIDFNvlgAgAA
X-CMS-MailID: 20180321043818epcas5p176fe0e0bbfce685420df2bfb7a421acd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180321043818epcas5p176fe0e0bbfce685420df2bfb7a421acd
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321043818epcas5p176fe0e0bbfce685420df2bfb7a421acd
X-RootMTR: 20180321043818epcas5p176fe0e0bbfce685420df2bfb7a421acd
References: <CGME20180321043818epcas5p176fe0e0bbfce685420df2bfb7a421acd@epcas5p1.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520689228013182?=
X-GMAIL-MSGID: =?utf-8?q?1595520689228013182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes "5f48f0bd4e368425db4424b9afd1bd251d32367a".
(mm, page_owner: skip unnecessary stack_trace entries)

Because if we skip first two entries then logic of checking count
value as 2 for recursion is broken and code will go in one depth
recursion.

so we need to check only one call of _RET_IP(__set_page_owner)
while checking for recursion.

Current Backtrace while checking for recursion:-

(save_stack)             from (__set_page_owner)  // (But recursion returns true here)
(__set_page_owner)       from (get_page_from_freelist)
(get_page_from_freelist) from (__alloc_pages_nodemask)
(__alloc_pages_nodemask) from (depot_save_stack)
(depot_save_stack)       from (save_stack)       // recursion should return true here
(save_stack)             from (__set_page_owner)
(__set_page_owner)       from (get_page_from_freelist)
(get_page_from_freelist) from (__alloc_pages_nodemask+)
(__alloc_pages_nodemask) from (depot_save_stack)
(depot_save_stack)       from (save_stack)
(save_stack)             from (__set_page_owner)
(__set_page_owner)       from (get_page_from_freelist)

Correct Backtrace with fix:

(save_stack)             from (__set_page_owner) // recursion returned true here
(__set_page_owner)       from (get_page_from_freelist)
(get_page_from_freelist) from (__alloc_pages_nodemask+)
(__alloc_pages_nodemask) from (depot_save_stack)
(depot_save_stack)       from (save_stack)
(save_stack)             from (__set_page_owner)
(__set_page_owner)       from (get_page_from_freelist)

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
 mm/page_owner.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 8592543..46ab1c4 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -123,13 +123,13 @@ void __reset_page_owner(struct page *page, unsigned int order)
 static inline bool check_recursive_alloc(struct stack_trace *trace,
 					unsigned long ip)
 {
-	int i, count;
+	int i;
 
 	if (!trace->nr_entries)
 		return false;
 
-	for (i = 0, count = 0; i < trace->nr_entries; i++) {
-		if (trace->entries[i] == ip && ++count == 2)
+	for (i = 0; i < trace->nr_entries; i++) {
+		if (trace->entries[i] == ip)
 			return true;
 	}
 
-- 
1.7.1
