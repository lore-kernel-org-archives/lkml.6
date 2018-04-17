Return-Path: <cgxu519@gmx.com>
X-Google-Smtp-Source: AIpwx48PVWNfmZRtsdumoHWfU4nBx9VurZ8VBtNaJWsu5i1q+nGA8B7E2dO9i+YJ1Fr9yNj189om
ARC-Seal: i=1; a=rsa-sha256; t=1523948769; cv=none;
        d=google.com; s=arc-20160816;
        b=HqeZljCBQ9VscpiKLdHbsiuFytjLhxlVjoWB9eoCGtZn0YerJA+L1gwGI7uYvDvfvm
         PPDMBVD3goHBf2PBzhKsF4h5K7GzqT7AHCm40TCME5EHLXmUj9HzfES+DctePfFDAulB
         cT/UX9k3svNF+IPzNt8GWAuZqXr/KxSvIUc63KOfY2F/9ODHJZr0tIQV160Eq+Y4nw3O
         aiGjoZSQM+sh7yq488K0wwi5LE5Lq5qMFQ5TvuRhipNzfmah15Mqb39KDolICnbeo0us
         6peFZtQg2Y7ykLMVBrc98WbLDO8Uo3X17RFpa7JAB1pWdLZvzo/y90vPL5NFlApUCenf
         iHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KdgJ1bXEEUgE0jlTMDiK5c25dLRsSEvZ34H3FosEZ9s=;
        b=a6wbJ9NvfIOehpZ/zwCoHQ+FfWOzDdQwU9eoSujMM/XxVaexSUSjxUpkLzOnA0x992
         9rRHHCXS8yRuQurKLII3VqK5POxrkC/Vxu23rN9py2AMiHOzc212LsoMEtZfQmQfTDNQ
         XlTMvBlJkHwWU1rERcxzpCRyN8Q4B+G/+iaX4IPJ6iVKfbd5i7TFv9MjGApR2wI6K8HG
         iGkNWnowUfkTCXtu8qlcimKJEGllEtEhgxSZNol82FVnY0WvpV54U5LC5k6Bm+GGabPD
         fXX4MwDEmRwILBoOVTEO4KPPGPmrzYoo3tMpc7nE0v3i3SCaNOB17wVfzccyDOCG9ytl
         pVow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of cgxu519@gmx.com designates 212.227.15.19 as permitted sender) smtp.mailfrom=cgxu519@gmx.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of cgxu519@gmx.com designates 212.227.15.19 as permitted sender) smtp.mailfrom=cgxu519@gmx.com
From: Chengguang Xu <cgxu519@gmx.com>
To: linux-fsdevel@vger.kernel.org
Cc: dhowells@redhat.com,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	linux-kernel@vger.kernel.org,
	Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 2/2] hfsplus: fix potential refcnt problem of nls module
Date: Tue, 17 Apr 2018 15:05:33 +0800
Message-Id: <1523948733-8537-2-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
References: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
X-Provags-ID: V03:K1:qYWhdORermWroev0TN4penUR9tZP1DnVRq5qRjNN4u/babdMUci
 3KaY0ypPuRMp/ddha/2p+ca1BYcShXyeGgnMJqMNuLejQtu5TNnOQ1ZrttRuh4B/rwfgpD6
 UichuSrOi+9VsGJMdPMShDv4lZOPGMnRivEEoCXd/C6H4A9YCfOp6yAgipU995DRkzWfeta
 GureiU8Z5q+rMR+h5Lorw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:onJ3H4B1/Ow=:Cd6BjvD5b+4ojWtwtG8L/7
 ZO65/bDIVNQXnDG7yvkFl9o6FvElmtwuA2X2UI9wt7tnaQUbJhPCXzG3j1GtlcIIH0Sl/GV14
 7u8g8nM82d2QAiFmCqYufUGVHcwxve8iYrZzf7BG2eISUZK+ebUJnwONADsjh+ei/NAv+oaRm
 Cto1uEoSEYkopzd+jJmXqUb7fzE3y6OkPBVCBPwnj2fbkw0uOpihJA+8GmbJVEwsjpxI+UdtE
 kjQB/kNDW6w+am8WnS21Se8w6ElLDDrbmo07/4mt48r/4MF6NH7KAQloLA/ZTZV2CaWPcE1fk
 4VGUUqIMiIEVGPvrmIsBObx5CuEB27bSHfAoxrJprnFsn/Y7DVffG+7JhwZiHbAqzba2Dxm1m
 rpxfwlG3sfOmp4K1O2Ic33tIigAu4ptZYHES+Q3vX5clEAMTIo7VPNhnoa7YDS/teT0CZc3Jt
 NRnG1zMW5YB87HNfaWhIPtGZG1XeQpEcdaKhFJr9pHokhW9mpjBQcm1xAnrCL4wQdQo+VEcjd
 tUDblEhZy/g9F1vnAI812Dlj/n3z8tytcfPMGDh6B8VKqptckBFi+X15mSCTiQpvdEAo605uG
 Zrlxlqi0Alx0AgRKOUglLkO60yPF4stqaqV/nVTqju7D86lxcRJx3r0KV4DN6r3rjvi2NgT41
 /OtbzBQI2zUFacjfvT1jULUvdn0x2zgVySVcxpiicv4Gs+3u5d/4myOJOcxjBh56qhs5eByup
 /VvYgRfeGJopXcDKqTS8FtxcHVsEXIz+kDC7fH1QVfeINkdE1Tn0sMH/dkKRNiKepNmeUBCku
 IcSoNrtY6rM1pQGq5a57NB9dxXpbA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597976104302734055?=
X-GMAIL-MSGID: =?utf-8?q?1597976104302734055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When specifying nls option multiple times in a mount,
current option parsing will cause inaccurate refcount of nls
module. Hence, call unload_nls for previous one in this case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/hfsplus/options.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index 047e05c..068d4e2 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -171,8 +171,10 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
 				return 0;
 			}
 			p = match_strdup(&args[0]);
-			if (p)
+			if (p) {
+				unload_nls(sbi->nls);
 				sbi->nls = load_nls(p);
+			}
 			if (!sbi->nls) {
 				pr_err("unable to load nls mapping \"%s\"\n",
 				       p);
-- 
1.8.3.1
