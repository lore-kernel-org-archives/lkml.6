Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AB8JxZo59Pr0nKylf7ukQbbe4bN89j5TNV0fI4zPy/ouRJoDr1QdZ1Qm7AaSGwsGo9nK53bH+W/u
ARC-Seal: i=1; a=rsa-sha256; t=1525685765; cv=none;
        d=google.com; s=arc-20160816;
        b=gETMZI4le5AZ5Vjauqv/umLBGzUrhG1l6tFS3mzpae5PjRhaQHq0vPcwIBNHNpJlEo
         AP0tsHE4cV3SKsyFAYbFXVBd31dCSctArIa4swxww8cCz8z4oID0gGqQ/gwk5Q7hsoZd
         KRQdN7WYs2dhcpHbfBvMy+JmTV19O7s/usykA/wDWQasttfQeNcHv/7D7nn+P0iu+Dy+
         yg3LbxN1hl+Kh04VfyWZKJuvpYAA9KUuAdBsm2JoqsKbh5fvLMoJEmKsvp6wO7y33Agb
         fW87q34e4kpBNVzjElwDwln5b79Ae+dNFqlyP3NkyQXxaZewZbE0bcvYGAC4ca1BYjyL
         xDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:references:in-reply-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:arc-authentication-results;
        bh=ByyqKaCe4V++OdQ/kLsp/6LM3rATAHmN2AwTuq4HR8c=;
        b=o9d9Q3QIe0K4FgSoUy/rhMRalsgHz8Jwu00jPvhCRupSMd9q9HbMQezYvqmR4flal0
         ghwen3ZkP/tLJ5zZ1qL1dxoJgOltEW/aSHRRwAS2aRq9RT5rLzINUmRbbObizbJQcoOX
         I5HPMKGIgyEvVK6HyvdGi+cTme+bEuSfk3hwNoDbS8OmiR9AzdHieq+lo7QK0SCfUOus
         1Rd7iVsvQ77Y5G7B4IY2q4yB/cE5MGSJ5ThERo51eeB/E0lODsfT3XHy85HpVa9oKkqi
         4ATpgq001rOWKoufUgIWv8e3O9ZB9QrXrqV7GDK0fK03v7JaBCdvOLRxE4OrJg1UV6+f
         d2WA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoffer Dall <cdall@linaro.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Thymo van Beers <thymovanbeers@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Rientjes <rientjes@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 08/18] docs: driver-api: add clk documentation
Date: Mon,  7 May 2018 06:35:44 -0300
Message-Id: <f3398bca6fba979bd55b8a053b6b46fe35bf9891.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797477086317378?=
X-GMAIL-MSGID: =?utf-8?q?1599797477086317378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The clk.rst is already in ReST format. So, move it to the
driver-api guide, where it belongs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/00-INDEX                          | 2 --
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/{clk.txt => driver-api/clk.rst}   | 0
 Documentation/driver-api/index.rst              | 1 +
 4 files changed, 2 insertions(+), 3 deletions(-)
 rename Documentation/{clk.txt => driver-api/clk.rst} (100%)

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index a9dd1384d8e3..2754fe83f0d4 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -80,8 +80,6 @@ cdrom/
 	- directory with information on the CD-ROM drivers that Linux has.
 cgroup-v1/
 	- cgroups v1 features, including cpusets and memory controller.
-clk.txt
-	- info on the common clock framework
 cma/
 	- Continuous Memory Area (CMA) debugfs interface.
 conf.py
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 865a24e4d516..42f3e2884e7c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -518,7 +518,7 @@
 			those clocks in any way. This parameter is useful for
 			debug and development, but should not be needed on a
 			platform with proper driver support.  For more
-			information, see Documentation/clk.txt.
+			information, see Documentation/driver-api/clk.rst.
 
 	clock=		[BUGS=X86-32, HW] gettimeofday clocksource override.
 			[Deprecated]
diff --git a/Documentation/clk.txt b/Documentation/driver-api/clk.rst
similarity index 100%
rename from Documentation/clk.txt
rename to Documentation/driver-api/clk.rst
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 3ac51c94f97b..5d04296f5ce0 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -17,6 +17,7 @@ available subsections can be seen below.
    basics
    infrastructure
    pm/index
+   clk
    device-io
    device_connection
    dma-buf
-- 
2.17.0
