Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Wz6/I9LRG/wljgfA612kjdB3QTqAmOUUyw9gX57Sp1mtliQvYNJQYqXt4Q18UpsWqzuzR
ARC-Seal: i=1; a=rsa-sha256; t=1522168742; cv=none;
        d=google.com; s=arc-20160816;
        b=QfR9nO8Ok64b5flPkCdTaCNous4cE0z2HK0uU/NDo/B+4juXqZrdKjBrCCCtWEbDCD
         DO2dC5ye8zWbMoEzhO7oJyLAmALKZhSvFRKTdHt4uNfBGWatznAQHTpUVGLxjIT0Yolf
         wpQr0wEEBXZ76xYicoaTBKzk3Dz+rA+KA9oNEvKBJlJSmcC3c2IMsrmL1faPnGuj/8te
         cR4xmqKLvhc72jfFC4AecUfWivuCN4ShO8DCCaXo5gT1cbBiVBgXXg5D2COZIQR+eEBz
         pnZShp0KjHsyvDBzXpJooeORmPDM5suX0WKXlyRo/ZB6thZ6QXfrtxeQqpFgMbwEsGaS
         g7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nmmvf4E9xJrhkEEHEOzLVsStvos8fwK1Nf+YOOa6f8E=;
        b=JeD0TRARurcfhJSxeToMbYwlTcvK7VtGV5ZExDc4ERqE4NKN8EyEmmaZlsUZU0584X
         nTzFXOd006v7uGbKa8MOgp7afvHKg/xvGt8PPE3EtZZok6ePgRzZCViun8dqFWDF2GQQ
         3n0K1KabB7PF0TZYw9YX1YM1xflLe8bQ3TPaXIvjCqJ7fZTjGidcRJpU+4ioTuspcb6I
         kan1ew3VLFdcDWcWUq4oJTqq5VzEU5OQ0J9AdCMd7xJWI8A6Z/r+qM1u9RGAxuC+IyCr
         B+tkx8A353CUCNBhshuu1m/SON6c+47rKjGoY+yychA8RZ4JhT3f4Yirjg0ytiRbFJvS
         Pc5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 016/105] mmc: core: Fix tracepoint print of blk_addr and blksz
Date: Tue, 27 Mar 2018 18:26:56 +0200
Message-Id: <20180327162758.523035714@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109302993996525?=
X-GMAIL-MSGID: =?utf-8?q?1596109610765566959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit c658dc58c7eaa8569ceb0edd1ddbdfda84fe8aa5 upstream.

Swap the positions of blk_addr and blksz in the tracepoint print arguments
so that they match the print format.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: d2f82254e4e8 ("mmc: core: Add members to mmc_request and mmc_data for CQE's")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/trace/events/mmc.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -86,8 +86,8 @@ TRACE_EVENT(mmc_request_start,
 		  __entry->stop_flags, __entry->stop_retries,
 		  __entry->sbc_opcode, __entry->sbc_arg,
 		  __entry->sbc_flags, __entry->sbc_retries,
-		  __entry->blocks, __entry->blk_addr,
-		  __entry->blksz, __entry->data_flags, __entry->tag,
+		  __entry->blocks, __entry->blksz,
+		  __entry->blk_addr, __entry->data_flags, __entry->tag,
 		  __entry->can_retune, __entry->doing_retune,
 		  __entry->retune_now, __entry->need_retune,
 		  __entry->hold_retune, __entry->retune_period)
