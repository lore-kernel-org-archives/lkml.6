Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ng9kKIX3/a0yydu2Ai0lsoMPD4gCCjsoiFs1M7dIKWgKc6UOYBlQhNGnT0zV9Q/f4OrHr
ARC-Seal: i=1; a=rsa-sha256; t=1518708006; cv=none;
        d=google.com; s=arc-20160816;
        b=BEi3Q8DDLLVucH57zNxb4K7ooy0H7VwUhFMY4OCcDGxPxw/YZIgce8bnDBdx7MkfV7
         Khka7gyvr6xHFwR6ZAcwXx6uIDObh89U1i2WfzJPxeqkI6M3x4vmJCc+luiI7Y/V9/Cf
         Cif9ORyfy0C4eKgmvcr7YTom6PzSLe6Gh1KO3ZOE2SqDBqwhydkA2w9jMu1zFLPl48EL
         291l5wOATclFzD+Tsz4SeNTj5xuL6r4zJyd7D4DUyIIN0YHSBwsEAD9NIZfzEbsSgy+J
         8d87ifv/Wjs+BEOHhImqDJchMW1+qHnm5kHJGJ7jyolvfakv4MRSqwylhRxuIO5PqQIk
         3jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6sLNmE9GyDgIQ/QjkMPoAbFGOKda1xAa6a6rZdYve2w=;
        b=vvjID6ZQ2kYmrds0sw6mic/GFMo09ZPGl8K5d0+F5Aat66mGq9zmqJ0R30Cy2HP2Tb
         zNEuZsNIj1axNnd8OdLrics3jC3stXuzgCfQn+iHxDFmWP1XTTOaRGw/h+WSFrm91gyy
         dDHsFT5dt9SZeAI4TSUg78VwDmXEIK3RoVFaMKc/mqMVzN2GuwZ3ZQh2X2srEVNtGk7o
         5yC4FNhZ2MRZmdC30IrhhQTMSHEqf+QjMVcFDCjKZ63M10AuruZqbykmK0pc2LAKtJza
         JemOgzXs8QlwuleKhURxidBDw6btzUoYjG0Xv/wCW2NgjdUeIPAKdi7aNW8h9/vth2iv
         OEug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3.18 40/45] alpha: fix reboot on Avanti platform
Date: Thu, 15 Feb 2018 16:17:31 +0100
Message-Id: <20180215144124.482155518@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480766762352193?=
X-GMAIL-MSGID: =?utf-8?q?1592480766762352193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 55fc633c41a08ce9244ff5f528f420b16b1e04d6 upstream.

We need to define NEED_SRM_SAVE_RESTORE on the Avanti, otherwise we get
machine check exception when attempting to reboot the machine.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/pci_impl.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -143,7 +143,8 @@ struct pci_iommu_arena
 };
 
 #if defined(CONFIG_ALPHA_SRM) && \
-    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA))
+    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA) || \
+     defined(CONFIG_ALPHA_AVANTI))
 # define NEED_SRM_SAVE_RESTORE
 #else
 # undef NEED_SRM_SAVE_RESTORE
