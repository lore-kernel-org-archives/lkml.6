Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1561004-1525724084-2-13079290236550453007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525724083; b=Z6wU6HDqI0ZSTHRc0Np1OsVi9P6t5Y269qvyil/pEOqCyKaoCg
    b/Mu1lfEbPMalw+GpDuyH8HV/DaNEiMmeNwcQDi4tVhqH9B+6ke6qeZy3ZRLOlon
    /Mpq0gHry7qccsp3ylS3cpjXvSEHu4qA8wJJ74NbXMutoKFj9pxCKTrXw3pvSt+U
    l0frN8bTonp1Nb5kvMjMlfcpdZUovPjbq0veM5v7TLa+jM06FUWH0d9o7rAv7VDS
    lNuyineKCZR2ejl/0mLZc7MkHE+FBwRf9wtr4pMzSctQlfUiLrLKOwssUeuivq2t
    WYN4NRWB/8S7X7tF6zG0TTzFaR5LP1ylhtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:content-type:content-transfer-encoding
    :sender; s=fm2; t=1525724083; bh=sT8NcuNogFcwPx+/X1fhH3N+zp7Yf7J
    YtTIEZI/29U4=; b=BD/miJNNJsxdhe0ULVQEbKYStbC0XfRbHMkTD3Z0hfA+5+3
    rJ3cSgdMCfNShIWwya7nMtrkOOUbigNk0vR40Nq3dWUNDKPNJ6q/yw76fvfgN8Rx
    P8KX33moKP5j/QIOWJLvW4ui0IGCCOPuNIW+G44u7Wag34/mfxoenWir5lEXNNVD
    96QtzNR4DT0qTXop3xFe8g9YWHCW4JQqtuKAh59FVhr2Pghljpeqh6iANhByAlI4
    ZP77W7ON5E6VMEMtdadVk4l+6aZvNPVSmloxOqWVFitD2Y60YuMC8B1aUrol80aL
    KgLsMqaOwmY7uugk638XNqAZlZnHI17zyuc9C5A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ens-lyon.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=ens-lyon.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ens-lyon.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=ens-lyon.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDdewFBrUualv0sOnGE5+9P07K+EZMIiqm/aIE9IomdQmB86UA+SiM/toWJUeISUtP5f5R/qKuH8gB1mOa99EGs/YmQyqpW71noee0VCZCKluIaZOsli
    SNLemAbmWSX4UnKJLPaCi4SiGfO8NB5oBIlf9fieN7x3wf6mfL8s+mKR59Su8l8MIMA2baky8S4ZJrwIT9vy77IfkwodG57LLr6A1CJEkHfB//Q+EcdMvjp2
    XmLJ3TuRrrd88PIZoTTeVg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=m8YGQp87AAAA:8
    a=DDOyTI_5AAAA:8 a=5ChXwagY5nP5fXg-G5AA:9 a=uBojFzxQenvaI21P:21
    a=0umTlZFuM52URdAX:21 a=CjuIK1q_8ugA:10 a=sQmdjVoOy41DRvcrsFdt:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 7 May 2018 22:14:27 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org, w.d.hubbs@gmail.com, chris@the-brannons.com,
 kirk@reisers.ca, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCHv2] staging: speakup: Add pause command used on switching to
 graphical mode
Message-ID: <20180507201427.hv5xncif3afs5roj@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 gregkh@linuxfoundation.org, w.d.hubbs@gmail.com,
 chris@the-brannons.com, kirk@reisers.ca, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, speakup@linux-speakup.org
MIME-Version: 1.0
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For software speech syntheses to be able to manage concurrent audio card
access, they need to know when speakup stops emitting text to be spoken
because the console has switched to graphical mode.  This introduces a
PAUSE command to do so.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
Difference from v1: fix codestyle issues.

 drivers/staging/speakup/buffers.c       |    4 ++++
 drivers/staging/speakup/main.c          |    6 ++++++
 drivers/staging/speakup/speakup.h       |    3 ++-
 drivers/staging/speakup/speakup_dummy.c |    1 +
 drivers/staging/speakup/speakup_soft.c  |    3 ++-
 drivers/staging/speakup/spk_types.h     |    2 +-
 drivers/staging/speakup/varhandlers.c   |    1 +
 7 files changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/staging/speakup/speakup_dummy.c
+++ b/drivers/staging/speakup/speakup_dummy.c
@@ -21,6 +21,7 @@
 static struct var_t vars[] = {
 	{ CAPS_START, .u.s = {"CAPS_START\n" } },
 	{ CAPS_STOP, .u.s = {"CAPS_STOP\n" } },
+	{ PAUSE, .u.s = {"PAUSE\n"} },
 	{ RATE, .u.n = {"RATE %d\n", 8, 1, 16, 0, 0, NULL } },
 	{ PITCH, .u.n = {"PITCH %d\n", 8, 0, 16, 0, 0, NULL } },
 	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -35,6 +35,7 @@ static int misc_registered;
 static struct var_t vars[] = {
 	{ CAPS_START, .u.s = {"\x01+3p" } },
 	{ CAPS_STOP, .u.s = {"\x01-3p" } },
+	{ PAUSE, .u.n = {"\x01P" } },
 	{ RATE, .u.n = {"\x01%ds", 2, 0, 9, 0, 0, NULL } },
 	{ PITCH, .u.n = {"\x01%dp", 5, 0, 9, 0, 0, NULL } },
 	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
@@ -154,7 +155,7 @@ static char *get_initstring(void)
 	var = synth_soft.vars;
 	while (var->var_id != MAXVARS) {
 		if (var->var_id != CAPS_START && var->var_id != CAPS_STOP &&
-		    var->var_id != DIRECT)
+		    var->var_id != PAUSE && var->var_id != DIRECT)
 			cp = cp + sprintf(cp, var->u.n.synth_fmt,
 					  var->u.n.value);
 		var++;
--- a/drivers/staging/speakup/spk_types.h
+++ b/drivers/staging/speakup/spk_types.h
@@ -42,7 +42,7 @@ enum var_id_t {
 	SAY_CONTROL, SAY_WORD_CTL, NO_INTERRUPT, KEY_ECHO,
 	SPELL_DELAY, PUNC_LEVEL, READING_PUNC,
 	ATTRIB_BLEEP, BLEEPS,
-	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG, DIRECT,
+	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG, DIRECT, PAUSE,
 	CAPS_START, CAPS_STOP, CHARTAB,
 	MAXVARS
 };
--- a/drivers/staging/speakup/varhandlers.c
+++ b/drivers/staging/speakup/varhandlers.c
@@ -45,6 +45,7 @@ static struct st_var_header var_headers[
 	{ "lang", LANG, VAR_NUM, NULL, NULL },
 	{ "chartab", CHARTAB, VAR_PROC, NULL, NULL },
 	{ "direct", DIRECT, VAR_NUM, NULL, NULL },
+	{ "pause", PAUSE, VAR_STRING, spk_str_pause, NULL },
 };
 
 static struct st_var_header *var_ptrs[MAXVARS] = { NULL, NULL, NULL };
--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -67,6 +67,8 @@ short spk_punc_mask;
 int spk_punc_level, spk_reading_punc;
 char spk_str_caps_start[MAXVARLEN + 1] = "\0";
 char spk_str_caps_stop[MAXVARLEN + 1] = "\0";
+char spk_str_pause[MAXVARLEN + 1] = "\0";
+bool spk_paused;
 const struct st_bits_data spk_punc_info[] = {
 	{"none", "", 0},
 	{"some", "/$%&@", SOME},
@@ -1780,6 +1782,10 @@ static void speakup_con_update(struct vc
 		/* Speakup output, discard */
 		return;
 	speakup_date(vc);
+	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0]) {
+		synth_printf("%s", spk_str_pause);
+		spk_paused = 1;
+	}
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 }
 
--- a/drivers/staging/speakup/speakup.h
+++ b/drivers/staging/speakup/speakup.h
@@ -94,7 +94,8 @@ extern struct spk_synth *synth;
 extern char spk_pitch_buff[];
 extern u_char *spk_our_keys[];
 extern short spk_punc_masks[];
-extern char spk_str_caps_start[], spk_str_caps_stop[];
+extern char spk_str_caps_start[], spk_str_caps_stop[], spk_str_pause[];
+extern bool spk_paused;
 extern const struct st_bits_data spk_punc_info[];
 extern u_char spk_key_buf[600];
 extern char *spk_characters[];
--- a/drivers/staging/speakup/buffers.c
+++ b/drivers/staging/speakup/buffers.c
@@ -77,6 +77,10 @@ void synth_buffer_add(u16 ch)
 	*buff_in++ = ch;
 	if (buff_in > buffer_end)
 		buff_in = synth_buffer;
+	/* We have written something to the speech synthesis, so we are not
+	 * paused any more.
+	 */
+	spk_paused = 0;
 }
 
 u16 synth_buffer_getc(void)
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
