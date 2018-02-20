Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x2274BWWxx+NRqBzgj4OVFTrKyACEteFd+WvAsdU+t1o40Ir/4d2RK/V6WPh4f1OBPQv3uNtt
ARC-Seal: i=1; a=rsa-sha256; t=1519131727; cv=none;
        d=google.com; s=arc-20160816;
        b=za0qJXSicpH7zs4qG6TeQMOILu3P1G2J3286GFfToHA7+6YfnAlSYgmC1SDMYoqImI
         R/RQtemz9vPSdC1Wbgu4ToA3pAgkH1FbI4vUDCYCKg8mbvKl/2djBRtGL1+rj5KVKe+N
         KLsGNRU8nkb4bTl4nLlmQroPBOyL2jYXY1L/UKk84prUteKGBjoSlXqin26VeIyL2cSg
         4u7C+YfitY4nCz4UqCq9PiSC8ubZZHeDgr95BtmhePIzlYjZeU4dSxjky0AdEqMZEpjD
         r02DZgeeH2bTU4BoHTsavKyscq/ynbiWFYrEaw2d3A4BlYk+/PpJ6IiUCpm5djwSjnxS
         xSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=3MTNjMLZMBs/bYPWWQziqTI096CaZzDcd+i/l9hSpzY=;
        b=0+f1vp8oGyE7uDRzjsjt79Y8U8FuPSnwRLBWEVw4e8tO0H6AVi9nVsJrT/mDopLzBM
         JEJO9Bx7GveCtJXd59uLbDbjmU4fHLo0Qz+3cR55wUJlfbdbUHNbOP3xhIuB37aHXXuC
         bJzlqF5MCb61arEpOhfRFN70dmtQcQZtz3a9S5TtfTCyOVIsgj3F1g0n/+4onhgz7wzI
         02LysW7Bd8+OjIckmsonQde3JaXdZTRlKahsRRB6z35u4tDTPy8uqFAPSSntLgVyrd45
         n2UFfyAGb6yDrDFp0UXXisrWEjlGtTOmiLV4CNtz15ED/+wRa2TdRrsTrQXAB62kdVUa
         J3SQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qAslzHwr;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qAslzHwr;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 20 Feb 2018 13:37:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 4.10 070/111] audit: fix auditd/kernel connection state
 tracking
Message-ID: <20180220123757.GE25314@hirez.programming.kicks-ass.net>
References: <20170328122915.640228468@linuxfoundation.org>
 <20170328122918.597715642@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328122918.597715642@linuxfoundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1563117219402183667?=
X-GMAIL-MSGID: =?utf-8?q?1592925070049257452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 28, 2017 at 02:30:56PM +0200, Greg Kroah-Hartman wrote:
> 4.10-stable review patch.  If anyone has any objections, please let me know.

> +	if (!(auditd_test_task(current) ||
> +	      (current == __mutex_owner(&audit_cmd_mutex)))) {
> +		long stime = audit_backlog_wait_time;

Since I cannot find the original email on lkml, NAK on this.
__mutex_owner() is not a general purpose helper function.
