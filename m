Return-Path: <kernel-hardening-return-12701-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvN3Uq9oU0d9GGTMfXJvpKZapoxv8DLalp1Nz5ZSaciQGk8C+NfDCxld5medIjqCokEwAm3
ARC-Seal: i=1; a=rsa-sha256; t=1521456332; cv=none;
        d=google.com; s=arc-20160816;
        b=TgCgm53vfOKw/F7MbvH+Enmo4dfqao+rX3OqcLrxpV30Zw/UMekxbz2fpOMxgtc9Zl
         qtnHe5FfIqTxs7WrD4Jv7I44YdWCTW0MBH4XgyMWM0aRINFi3gPGPEp3hn5/dKsjp9NP
         mtwZ0FV5EqvCViiLxVB/1rADg4yMpOAlSrqR2Hgq1SuA4pA1EA99G1rVRXjvNqUV0sxf
         gFt02OUCsu8hvzmrKoTYvrmdBvOogOHfDMiWqJVIHTvBiGp713dS9R20qkKkoKrcr44L
         slKR8P8Qs290FFVph/7WWusAzaQpy3ZemKmkM4Vaja3XGt3JCBoV215aJrvVFiMpRewV
         /PXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=d+BDbftqlKEm2GYgkCVqqTBpV902ePPKsgGcJNbZ/UU=;
        b=LGtOJDRyJ5ciJVDV2pIp1v0HB+yYEYklCqy99T4XALNQUtS1vlcYyPzEUTvzSsdOY0
         hWtl6GvnvDo9tJqwT8yyvkUTwl3H+E4kXXlUPZ4GyuEr/ihtgkhQBh0i7MhlbzKb2jUg
         OpI+AVP6hc9GTqwtM+1v6nvcCJ8AgRlMpe4DL3yqwDQkenn88X9fUMQXCsRZMI3GnYT/
         uueW9UHTNoLDt8553iqDtU/lwHnRNDYKvFB7yORofjYdonIfI90tqE9QAAAElHbe0UbN
         0ZgTcsSllc9tYoyS46lT464nRvyL7fo8WpYwv/c531eBuiLbfNt2MfKrtcZ7Mn+QZdS2
         +sWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rsC4eBho;
       spf=pass (google.com: domain of kernel-hardening-return-12701-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12701-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rsC4eBho;
       spf=pass (google.com: domain of kernel-hardening-return-12701-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12701-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v5 2/2] Remove false-positive VLAs when using max()
To: Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Randy Dunlap <rdunlap@infradead.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, David Laight <David.Laight@aculab.com>,
 Ian Abbott <abbotti@mev.co.uk>, linux-input@vger.kernel.org,
 linux-btrfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <1521174359-46392-3-git-send-email-keescook@chromium.org>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Message-ID: <22223483-f668-7158-336f-d3036253ea20@gmail.com>
Date: Mon, 19 Mar 2018 13:45:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521174359-46392-3-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595362594564921107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 07:25 AM, Kees Cook wrote:
> As part of removing VLAs from the kernel[1], we want to build with -Wvla,
> but it is overly pessimistic and only accepts constant expressions for
> stack array sizes, instead of also constant values. The max() macro
> triggers the warning, so this refactors these uses of max() to use the
> new const_max() instead.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/input/touchscreen/cyttsp4_core.c |  2 +-
>  fs/btrfs/tree-checker.c                  |  3 ++-
>  lib/vsprintf.c                           |  5 +++--
>  net/ipv4/proc.c                          |  8 ++++----
>  net/ipv6/proc.c                          | 11 +++++------
>  5 files changed, 15 insertions(+), 14 deletions(-)
> 

FWIW, the patch below is alternative way to deal with these (Note, I didn't test my patch, just demonstrating the idea).
It's quite simple, and should work on any gcc version.

This approach wouldn't work well for CONFIG dependent max values, especially in case of single constant
expression being dependent on several config options, but it seems we don't have any these.


 drivers/input/touchscreen/cyttsp4_core.c | 3 ++-
 fs/btrfs/tree-checker.c                  | 3 ++-
 lib/vsprintf.c                           | 6 ++++--
 net/ipv4/proc.c                          | 4 +++-
 net/ipv6/proc.c                          | 6 ++++--
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 727c3232517c..ce546a3fad3d 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -868,7 +868,8 @@ static void cyttsp4_get_mt_touches(struct cyttsp4_mt_data *md, int num_cur_tch)
 	struct cyttsp4_touch tch;
 	int sig;
 	int i, j, t = 0;
-	int ids[max(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
+	int ids[CY_TMA4XX_MAX_TCH];
+	BUILD_BUG_ON(CY_TMA1036_MAX_TCH > CY_TMA4XX_MAX_TCH);
 
 	memset(ids, 0, si->si_ofs.tch_abs[CY_TCH_T].max * sizeof(int));
 	for (i = 0; i < num_cur_tch; i++) {
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 8871286c1a91..ad4c2fea572f 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -346,7 +346,8 @@ static int check_dir_item(struct btrfs_fs_info *fs_info,
 		 */
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
-			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+			char namebuf[BTRFS_NAME_LEN];
+			BUILD_BUG_ON(XATTR_NAME_MAX > BTRFS_NAME_LEN);
 
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 942b5234a59b..fa081d684660 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -754,13 +754,15 @@ char *resource_string(char *buf, char *end, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
-		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
+	char sym[2*RSRC_BUF_SIZE + DECODED_BUF_SIZE];
 
 	char *p = sym, *pend = sym + sizeof(sym);
 	int decode = (fmt[0] == 'R') ? 1 : 0;
 	const struct printf_spec *specp;
 
+	BUILD_BUG_ON((2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE) >
+		(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE));
+
 	*p++ = '[';
 	if (res->flags & IORESOURCE_IO) {
 		p = string(p, pend, "io  ", str_spec);
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index d97e83b2dd33..9d08749de8d0 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -46,7 +46,7 @@
 #include <net/sock.h>
 #include <net/raw.h>
 
-#define TCPUDP_MIB_MAX max_t(u32, UDP_MIB_MAX, TCP_MIB_MAX)
+#define TCPUDP_MIB_MAX TCP_MIB_MAX
 
 /*
  *	Report socket allocation statistics [mea@utu.fi]
@@ -404,6 +404,8 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 	struct net *net = seq->private;
 	int i;
 
+	BUILD_BUG_ON(UDP_MIB_MAX > TCP_MIB_MAX);
+
 	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
 
 	seq_puts(seq, "\nTcp:");
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index 1678cf037688..3ad91dae7324 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -32,8 +32,7 @@
 
 #define MAX4(a, b, c, d) \
 	max_t(u32, max_t(u32, a, b), max_t(u32, c, d))
-#define SNMP_MIB_MAX MAX4(UDP_MIB_MAX, TCP_MIB_MAX, \
-			IPSTATS_MIB_MAX, ICMP_MIB_MAX)
+#define SNMP_MIB_MAX IPSTATS_MIB_MAX
 
 static int sockstat6_seq_show(struct seq_file *seq, void *v)
 {
@@ -198,6 +197,9 @@ static void snmp6_seq_show_item(struct seq_file *seq, void __percpu *pcpumib,
 	unsigned long buff[SNMP_MIB_MAX];
 	int i;
 
+	BUILD_BUG_ON(MAX4(UDP_MIB_MAX, TCP_MIB_MAX,
+			IPSTATS_MIB_MAX, ICMP_MIB_MAX) > SNMP_MIB_MAX);
+
 	if (pcpumib) {
 		memset(buff, 0, sizeof(unsigned long) * SNMP_MIB_MAX);
 
-- 
2.16.1
