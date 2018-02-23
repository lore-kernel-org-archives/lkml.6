Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224yr5v4juoBmUw/MnfBs3U87vhb7sFHyeGxWYayNxmBHuOFqUW2D5jwoqcNfpf4mhG+/zDG
ARC-Seal: i=1; a=rsa-sha256; t=1519411174; cv=none;
        d=google.com; s=arc-20160816;
        b=f6svxIvGZt2JB2fEgfhXZg4+AdBnM7pDpB2oSfzoZDIieb8DtbvHFHHhcnM6hTi/+E
         m5lrbk6pBbuPIs1dgE2VgfOIGcwE1OwASiXPL4gSH2pjhpvGywgrHPPMRS2jfMyCNi1M
         63AWEttZZ0ErfC5jTRWuN+Zvnvb3FVjGc9Bt3NA0elE2A6rBCpPLe/53lYFopFN9ugi/
         shCoyyT+M3IlUCQ1ybGxMz+k/BAyQBHUqY2m/GbO673s1pzdtYxeotCpUOOZq1N/D5G1
         3nsG+AHvicCPpoZTcI/0At1m0XL9v+x2hJadTxXdYemsre/uMcr2pR3laZAQFDB6q6tZ
         L7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cvxvedj7WFIfSEySznpzeZuDN1lts0NAkg7wkqziX/E=;
        b=ifqSkpZk5K3wTqQUkRhCU5jymYmTJb8djGe5GXrpB4/R6nYJbDTw4l7X+Femwbj+FD
         6AefVkt7TVdhCcO/aEpe4uley8HfthVN3E+vbeSHfaqW9wfFJmXVSToyrQsJ3LHI9pUK
         sC8kwoRw1IE9wrWMQusN+eVGQWXjtXB4APZvqoOUQx192vEekcO+CS0U3EKnJ6O1XqlL
         oX41ycfNAFifK+rgNaCZAqmQV4/QFAcAxUhy5bsZzRBps3t1Mev6slvhTHUnwEbBOzKO
         7nSweVGXxwF8Pkag95lTi0+JqKQVNgYTqOJwLsbRcuVj3T4GCOOlxBNS1ofKLzianA4E
         /1Gg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jun Nie <jun.nie@linaro.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4.4 145/193] dmaengine: zx: fix build warning
Date: Fri, 23 Feb 2018 19:26:18 +0100
Message-Id: <20180223170348.613101917@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218091104160215?=
X-GMAIL-MSGID: =?utf-8?q?1593218091104160215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jun Nie <jun.nie@linaro.org>

commit 067fdeb2f391bfa071f741a2b3eb74b8ff3785cd upstream.

Fix build warning that related to PAGE_SIZE. The maximum DMA
length has nothing to do with PAGE_SIZE, just use a fix number
for the definition.

drivers/dma/zx_dma.c: In function 'zx_dma_prep_memcpy':
drivers/dma/zx_dma.c:523:8: warning: division by zero [-Wdiv-by-zero]
drivers/dma/zx_dma.c: In function 'zx_dma_prep_slave_sg':
drivers/dma/zx_dma.c:567:11: warning: division by zero [-Wdiv-by-zero]

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/zx296702_dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/zx296702_dma.c
+++ b/drivers/dma/zx296702_dma.c
@@ -26,7 +26,7 @@
 
 #define DRIVER_NAME		"zx-dma"
 #define DMA_ALIGN		4
-#define DMA_MAX_SIZE		(0x10000 - PAGE_SIZE)
+#define DMA_MAX_SIZE		(0x10000 - 512)
 #define LLI_BLOCK_SIZE		(4 * PAGE_SIZE)
 
 #define REG_ZX_SRC_ADDR			0x00
