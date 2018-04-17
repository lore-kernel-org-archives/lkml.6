Return-Path: <cgxu519@gmx.com>
X-Google-Smtp-Source: AIpwx4/XNASIsC2cISeZG3x4F7oqcObrw2x56+KLcOynKEer9I0ch4DGHzyRFLXMPWNExBYZJ5Ee
ARC-Seal: i=1; a=rsa-sha256; t=1523948762; cv=none;
        d=google.com; s=arc-20160816;
        b=AsXGD3pgEcIecpDoVP1g2hmjSCYxTohoOW4Omki7wPYVhTUxn0Q3Ib1KUZUNeuyr0d
         txp6gYnAy2g8djhCyGsVt8NZqCsM93GKoOrCCeeuezhzp7RbIZa8oW4ns5NzVvbjQ2d+
         AcNdYZ02Oa7Ht2E0LG2G3+Swd3BS+lxCoAMRFY3TLDyxMsvkL3BZWOtSD632Jz4F4cDP
         w4cw8M3ePOEXpVcbdbJauaCsgvXigrk0JHtDfNypQKb/FCIa/Uq9OqafNYqXbVCVPDJ3
         dUsdd7etYj0Sj+7RDhm+3Mf4/xKLLpezi/Uzh99jjB7wicHeD/SUeAhPN6ybblQu4iIC
         lMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=mh2ambuFYPmcQwIG7PF0N/3xYvXpJXTxXc/EWuvWiEc=;
        b=CYtiNxihBnrWZSXoV3K5dAryW2jDkXCivmd6DJJBZ5juxchBuvXivIkzpIhdQ4XxGF
         S7Xl1FQ3ejPBK8Gx/I17E04JkmSA18CMdr3Crx4Cc0JmqlJCG0zQr1bmH4MBz5b0Y1N7
         z02k6Iq9+y7Y/Jo12jXYmLljIY3NtKGYxfjAbBPnrc/K9tSFSJ6boxgq/TP3uJaF1lbf
         0Z/hhrSMdZDWoBp4DgzT0n/0t1TWsFylWRHrcngPRQCcTU3gBWXaip/wQy4Y85YtX/1P
         TmWacs2Cab4dAsSw8sKzREVDENoqm4qxOmkWoEuz1+IbesutNL65PA9hiQV61YhVgfax
         2a2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of cgxu519@gmx.com designates 212.227.15.18 as permitted sender) smtp.mailfrom=cgxu519@gmx.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of cgxu519@gmx.com designates 212.227.15.18 as permitted sender) smtp.mailfrom=cgxu519@gmx.com
From: Chengguang Xu <cgxu519@gmx.com>
To: linux-fsdevel@vger.kernel.org
Cc: dhowells@redhat.com,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	linux-kernel@vger.kernel.org,
	Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 1/2] hfs: fix potential refcnt problem of nls module
Date: Tue, 17 Apr 2018 15:05:32 +0800
Message-Id: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:CszVP9qSHiabmQSPp3S+gVMkrDlcQ+163q4l5dvsX0bpmwqAtpb
 274E+IvC4kXItRaK+aTncnei/kYYBro6AgdxO9E3mk3PQLKX0g/lwYNoZeumCDkIwWAgAXg
 cK8P36XLh9l7//1pnz2tpnEf4dg9BdqmfKk7e8BvETOwLNWe4mpalbTrk/7g0Kdoodk5BCh
 ipdVQGKQonSmyFRL3UZCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LfNcpRB+o+U=:n7mr84JBK/SiRIggmlktPV
 GRwTuXsVJLeAu4ZVvSvtEClYs1Uw6H0ejTHmnK0V8waVJ+ty9FeYpFiL80crPaLjwsbROlD2/
 qm1gVwl7XzoYAkxGwJEIEQbcmioEGso1PwXcP5mFA1C7tMx+koWGuDIyi/C5ReyWrqyHgkFaC
 pQYsBvXxE4sOpyFXoY7b5sA4vBi6M26Sp8CWuEceZCeZ7Rbce2cw6XbjBtXfnLzQaSHk8txFE
 b4tM2VjDSNEmJ167zIfRz+llDy9y+0c3OeNZFQroJxObnBLECJtP1AoKnQ04s8hSsP+xX/L0G
 uoBTnNXHVQKSo+Bt5EBO7CE+eRLap7q2eXQeISHPcAU+ZkIqaBqWUUtKs1YEP+zpjXqJQwR+8
 fEyziF2HiXAsgkPj70jGqqO776LA15tUemRkgVF0aJBInq0ewIX5s+ASl8qIlXgnASXhJyc1k
 frbSNbXHP+GzKUtS05NbQ9TSEOPBkNxufQB5g3RQtCvWt50e8X4BG39sxk13HE7kRQ32a1Ehq
 dlFL6HeZWj3ZbKDeNw9OsWPoLPLcIpvunm74M2mbPzXismzNRZeCjD4AuhtmpZRot3OJeBU8O
 cT6bosHxkayvNqNbWOhUjGtvYdmeS7zcIO1fAVf+HGiYJMQFVoB9Zjnnm3E59Hj1vMBFEcpVk
 8sqn4gZ2vdLTVikwkBT3UkFce9NLFp6cFpy7osftQqNPik6uRXEp9Gj9IsVMGKcPxfeD4J2UA
 Qlo/TF+0ZnYFhEYgZOgsG/Ex8jxEboEZnNsweSS9npSTxqq10e1A9iH6hbbAvupE6mdByzDhq
 QoDgdDoqfZjEIx4QTaiC3kN/sCqSg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597976097754652065?=
X-GMAIL-MSGID: =?utf-8?q?1597976097754652065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When specifying iocharset/codepage multiple times in a mount,
current option parsing will cause inaccurate refcount of nls
module. Hence, call unload_nls for previous one in this case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/hfs/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 1738767..6a5f6fd 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -329,8 +329,10 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
 				return 0;
 			}
 			p = match_strdup(&args[0]);
-			if (p)
+			if (p) {
+				unload_nls(hsb->nls_disk);
 				hsb->nls_disk = load_nls(p);
+			}
 			if (!hsb->nls_disk) {
 				pr_err("unable to load codepage \"%s\"\n", p);
 				kfree(p);
@@ -344,8 +346,10 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
 				return 0;
 			}
 			p = match_strdup(&args[0]);
-			if (p)
+			if (p) {
+				unload_nls(hsb->nls_io);
 				hsb->nls_io = load_nls(p);
+			}
 			if (!hsb->nls_io) {
 				pr_err("unable to load iocharset \"%s\"\n", p);
 				kfree(p);
-- 
1.8.3.1
