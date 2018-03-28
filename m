Return-Path: <kernel-hardening-return-12812-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+Dti+L30QJvObVggHKJAzu0jOVJ1qbuDfx7/ArscXfItcEaERIbNSPisAYbagXyZTV/diE
ARC-Seal: i=1; a=rsa-sha256; t=1522270679; cv=none;
        d=google.com; s=arc-20160816;
        b=gR8buxoqFqEM5MAPNNq3AaGuBMORjtmc9Dv+/l7pV1O6y6IbLneOISeMi9NxaRHplf
         2AxJvEDGlMaFhmRb8fjSm1pRHYlO57PwIiYCkCZb/zUjpt6sjLHfXD8v4ZaHdMLodjsH
         S6Pv2ZFwWX0srfwa3kdT3kHmBl0MYRCZs/VOIuLrIZkPPZX+NwqQgN2+c2dlBSaSp4am
         2FovHQIjo9OT2R4EDSYzl8tT6/BEmk8GTlPh647cz3HpZ2gKwYmTApaYktwOiyWOq7ur
         va1/Xn41Zgy2a08nwbyAeCjzhBsa1vaXq1QPuiijnLkgBnQgCPxEWDrpyJVah5+EVv6G
         CjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=N0LmixLNl8LTyM0ed3YAJ1E7MQsBzDb6bSW/RRGSxWI=;
        b=BWa6uR0xRYNlmNDpbVCumhcuzd+ebRUwkvrbdYqw/gkjWqiY8l4+KsIrUirJtpB5UN
         fscx8QkbInWLU7XlsRa9oVcA+9w/7C/8LDvqdUzc3Lf2/lSpNUQVw8iUQ4PpWppuQW+N
         CUFkdWe3cf8Z7R7vekpCv7WI6ofQNTtlVdgWfY5S268Rc1Jfq+KD9/BpNXfudoBwxfV/
         KLv9/nRvgb61FiIy48XKrnA39AX0+00cIDJoZjXGa7R8iRGXBzLs2CCDLGRbzJ/r9P+M
         4aBijg/JUlSj9VRDRGS6n531EqaTeEZAQJFvt7lgy2s4QOMXXSZkIBCivWi/l1ls1aWD
         xdWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12812-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12812-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12812-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12812-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180328205554.321596143@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 28 Mar 2018 22:51:39 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Andrew Morton <akpm@linuxfoundation.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>
Subject: [patch 1/8] rslib: Cleanup whitespace damage
References: <20180328205138.301218351@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Cleanup-whitespace-damage.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596216500153147779?=
X-GMAIL-MSGID: =?utf-8?q?1596216500153147779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of mixing the whitespace cleanup into functional changes, mop it up
first.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rslib.h           |   14 +++++++-------
 lib/reed_solomon/reed_solomon.c |   20 ++++++++++----------
 2 files changed, 17 insertions(+), 17 deletions(-)

--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -39,15 +39,15 @@
  * @list:	List entry for the rs control list
 */
 struct rs_control {
-	int 		mm;
-	int 		nn;
+	int		mm;
+	int		nn;
 	uint16_t	*alpha_to;
 	uint16_t	*index_of;
 	uint16_t	*genpoly;
-	int 		nroots;
-	int 		fcr;
-	int 		prim;
-	int 		iprim;
+	int		nroots;
+	int		fcr;
+	int		prim;
+	int		iprim;
 	int		gfpoly;
 	int		(*gffunc)(int);
 	int		users;
@@ -80,7 +80,7 @@ int decode_rs16(struct rs_control *rs, u
 struct rs_control *init_rs(int symsize, int gfpoly, int fcr, int prim,
 			   int nroots);
 struct rs_control *init_rs_non_canonical(int symsize, int (*func)(int),
-                                         int fcr, int prim, int nroots);
+					 int fcr, int prim, int nroots);
 
 /* Release a rs control structure */
 void free_rs(struct rs_control *rs);
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -64,7 +64,7 @@ static DEFINE_MUTEX(rslistlock);
  * en/decoding. Fill the arrays according to the given parameters.
  */
 static struct rs_control *rs_init(int symsize, int gfpoly, int (*gffunc)(int),
-                                  int fcr, int prim, int nroots)
+				  int fcr, int prim, int nroots)
 {
 	struct rs_control *rs;
 	int i, j, sr, root, iprim;
@@ -191,14 +191,14 @@ void free_rs(struct rs_control *rs)
  *  @gffunc:	pointer to function to generate the next field element,
  *		or the multiplicative identity element if given 0.  Used
  *		instead of gfpoly if gfpoly is 0
- *  @fcr:  	the first consecutive root of the rs code generator polynomial
+ *  @fcr:	the first consecutive root of the rs code generator polynomial
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
  *  @nroots:	RS code generator polynomial degree (number of roots)
  */
 static struct rs_control *init_rs_internal(int symsize, int gfpoly,
-                                           int (*gffunc)(int), int fcr,
-                                           int prim, int nroots)
+					   int (*gffunc)(int), int fcr,
+					   int prim, int nroots)
 {
 	struct list_head	*tmp;
 	struct rs_control	*rs;
@@ -207,9 +207,9 @@ static struct rs_control *init_rs_intern
 	if (symsize < 1)
 		return NULL;
 	if (fcr < 0 || fcr >= (1<<symsize))
-    		return NULL;
+		return NULL;
 	if (prim <= 0 || prim >= (1<<symsize))
-    		return NULL;
+		return NULL;
 	if (nroots < 0 || nroots >= (1<<symsize))
 		return NULL;
 
@@ -252,13 +252,13 @@ static struct rs_control *init_rs_intern
  *  @gfpoly:	the extended Galois field generator polynomial coefficients,
  *		with the 0th coefficient in the low order bit. The polynomial
  *		must be primitive;
- *  @fcr:  	the first consecutive root of the rs code generator polynomial
+ *  @fcr:	the first consecutive root of the rs code generator polynomial
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
  *  @nroots:	RS code generator polynomial degree (number of roots)
  */
 struct rs_control *init_rs(int symsize, int gfpoly, int fcr, int prim,
-                           int nroots)
+			   int nroots)
 {
 	return init_rs_internal(symsize, gfpoly, NULL, fcr, prim, nroots);
 }
@@ -271,13 +271,13 @@ struct rs_control *init_rs(int symsize,
  *  @gffunc:	pointer to function to generate the next field element,
  *		or the multiplicative identity element if given 0.  Used
  *		instead of gfpoly if gfpoly is 0
- *  @fcr:  	the first consecutive root of the rs code generator polynomial
+ *  @fcr:	the first consecutive root of the rs code generator polynomial
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
  *  @nroots:	RS code generator polynomial degree (number of roots)
  */
 struct rs_control *init_rs_non_canonical(int symsize, int (*gffunc)(int),
-                                         int fcr, int prim, int nroots)
+					 int fcr, int prim, int nroots)
 {
 	return init_rs_internal(symsize, 0, gffunc, fcr, prim, nroots);
 }
