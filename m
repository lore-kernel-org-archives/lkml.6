Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49/6NFxh/jvpLdBHbQ/gt8n95ce7cQpD9CZClMHglurmK8Tuitd5YaTFSCY6J38duAzd4ME
ARC-Seal: i=1; a=rsa-sha256; t=1522346727; cv=none;
        d=google.com; s=arc-20160816;
        b=Qw1TUMNDK4Wbs6I9o8XF1feE6yg50q2KKH06puSCKRLwZOCqFS/RXhPmrnvCcMfvNT
         SVmH3tv/0NqwaUGtXUoIogRr6dMFIUhfEfjLplmhgxUwA1HZoFPVkfT1Io+8i+u0SDjc
         9gnA4iVphSisvXP1VnTC+Agmqk8fh4i8dAn5/aQxtRb8o4cM12tMQYhTDIikUF/T5JQw
         yJF78o1Zk9Zs7ik696CfYvfK3M4BOAl3mZe98B70bAaLc6mL+oQhevnNWOsYiRmImMo+
         njHC3S5LocpF6OlFi6INp27otSUbom8FR9MB81hHE0HTpfcQxVyCadRRLxg4kXIWjUj7
         l5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S0U8WfFmaApU1+y/MnNRCn8DjmVkR0HYLXqLtOlIIoQ=;
        b=Z9zovjQ+YbzmAqQlaB4nhMCgL0O2Bmy7CitrtV547GVODoZF/erXBYsxpsplT6u8oy
         QifdIPgvi8meux7oBHf/hp484J0nENKaZzFCHhVCWA91n4+w+9dYxePy83vqfS0DAaiZ
         8EewOt9ZVbCc1K8ZuBw/q94+PiHPGa7P1btZ3bu16bLqkrmdKEzHS/ewVWB4qzFdxyQn
         1seqwSm4ZXFgMZ8MTQgWtY6p6EP6w7kdAmJ713Z0MIHm1QVF22uRJo8EGow/TxtBSlsg
         DTd2a6QPDqGD4mvJzNmw9KgyWadh/GWwT7tIGHPnul83KA8jQmUpIh6vd8EWdpLTguyx
         lX6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Camelia Groza <camelia.groza@nxp.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 37/43] dpaa_eth: remove duplicate initialization
Date: Thu, 29 Mar 2018 20:00:32 +0200
Message-Id: <20180329175734.191238528@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296080196572960?=
X-GMAIL-MSGID: =?utf-8?q?1596296242543621319?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Camelia Groza <camelia.groza@nxp.com>


[ Upstream commit 565186362b73226a288830abe595f05f0cec0bbc ]

The fd_format has already been initialized at this point.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2292,7 +2292,6 @@ static enum qman_cb_dqrr_result rx_defau
 	vaddr = phys_to_virt(addr);
 	prefetch(vaddr + qm_fd_get_offset(fd));
 
-	fd_format = qm_fd_get_format(fd);
 	/* The only FD types that we may receive are contig and S/G */
 	WARN_ON((fd_format != qm_fd_contig) && (fd_format != qm_fd_sg));
 
