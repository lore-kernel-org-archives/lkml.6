Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx4/pfi2BgHi764IX9SAHVhEAvHddvzgYFyXXy0KRRrlSqvCfk+jVk8zbxuNiRNOhGWFVhIzt
ARC-Seal: i=1; a=rsa-sha256; t=1524652433; cv=none;
        d=google.com; s=arc-20160816;
        b=ki6Sf+vMqr4k4toGIYVg9YreynRoPDh3Cm4d6BoACcP0lzYHw8Gd5KQMq/co6YXOZg
         S/QI9i73y24Exr52RrXwi6g+Af0grY+8ATxbkWmezhi2Ny5d02+iVdNn0TgWDOLRf/F+
         pn8Gi0CYItysakMJxUBSkJ6tS+sULhDQ8oIZ2gyOXzyisHgcrTQ7fc3leyN0T7Md+Wz5
         zpot7/jtyQEQBBGkNNAECSCQw3VQGe2j5/8uztDiSoSpGgDzZ4MyhMExJxhxb8to7tyQ
         jkKTOJIWhi0JH2DKexWvFoZE5TkCZgA0oxKIIQytlm0ZLyAcWC28BvgAkdF1StYS0Oew
         pPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bKh7vhfF9SrL1sjt1zE0HWt7edQ8q4NT3rujyNPOamY=;
        b=Ce5ConADU/b3zVULTNJuW8ReKHR6p7+MMgf1QvbXnV5cM/a+C8ZkSRKXY/xX/ieRwl
         nIPuLmq3fnaR0tnbdAmzriTgrvUtqbIj6kDmMH0qcFTS7gDvwjtN4rHAKBDUr1UpLSs3
         jcPRUlrGEtAH7d9lWtNpt5HbmNT7jt8wlMJhXBJAIYBKpFknd4m7E4wkBPTzXbuOihYq
         IQL2rDPCqoWEITV/70K8W8pWB7HtBW0P/EEBwe90bdjCoH4QZWol2W6S7cewM5jo2mcU
         BcJ1/KddV1E22pgyvBX7BPLDJtgbTn6w/sEqROcPuvYqwCbpyFXl27ha3DbbWYsdZCvA
         SiYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.82 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.82 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <hpa@zytor.com>, <gregkh@linuxfoundation.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v3 0/2] MCA support for Centaur CPUs
Date: Wed, 25 Apr 2018 18:33:38 +0800
Message-ID: <1524652420-17330-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598713949686597449?=
X-GMAIL-MSGID: =?utf-8?q?1598713949686597449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set is to provide MCA support for new Centaur CPU.

The first patch is used to tell the kernel that newer Centaur
CPU support MCE broadcasting.

The second patch is used to tell the kernel that newer Centaur
CPU support CMCI.

Changes from v2 to v3:
* move mca_cfg.monarch_timeout init from __mcheck_cpu_apply_quirks to
mce_centaur_feature_init according to request from Boris.

Changes from v1 to v2:
* Capatilize 'Centaur' in the comments

David Wang (2):
  x86/mce: new Centaur CPU support MCE broadcasting
  x86/mce: add CMCI support for Centaur CPUs

 arch/x86/kernel/cpu/mcheck/mce.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
1.9.1
