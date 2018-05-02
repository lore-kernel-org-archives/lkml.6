Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4018576-1525222584-2-4189592339879651652
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525222583; b=JdqtI4WHFCx5xuOqjSPshqBr3zcq6k+s9XQ6BKkUT1sW/hW6dv
    /f4stPoNrTPvbt/614dldpo1UOWTImXqhNaYI//aX6qDIPyhJODMvyJEOjN2vyPg
    CQqRMJ/5mlnAmWrIJAR8LvKotKFNuE+EcfVcU5S5r13ePRxOQJg06ArcHLcs4U+d
    StueJcqCHdCoezEAN0UfqtYnhaumfJCJpZKV+YTPYgA4/MEtDXg0+1z/9KTir9JX
    Rff/WxVeTDlBEu/m3tN6hmVwRSedLL36aU3AJ3sNHjWEhkapAnPy1o07k34g2HJL
    yDKMu6/iw6VOwuOnGupbrq0K2GUWb/ol3Y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:content-type:content-transfer-encoding
    :sender; s=fm2; t=1525222583; bh=XjPfL0HsnsIIKWchWVDCRRy3kLbUWIM
    oOjaQI+0X8/A=; b=iuCYyv1rSi6ON0SjYS6LfhehPEQciTydTuI18n0+5i7CzBr
    1LeUB0a6uKu++XSziJQIMP7xq4nPyBzsFnznheEA73kaPAdGya/xjFJPQXSs7nnQ
    IpPQb0j9JLWiQlOgK7cadmWEhm1YuGySpWxKDSARzeAHGMhmkEZ7DB8ySsmCfGtp
    tCNiTzxfnlCoJpDGZHMUlDxct3ywPyohg+rNFZC14cxmLUxjPfkHbFMnfbDc7rvl
    8DA0a1Q8CSlZe0cVeeyCDtuUJi1T5i5ebWJHBcDkBCmWKWbEhR3NpvVOCFF8Dfwi
    KqhMPZBOTSqkhY6zPDbid0gaTn50gN1UGMuxbJA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ens-lyon.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
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
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=ens-lyon.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG5uh+mBm7+fzf7U6Is53iC9dyIaBKPIV5UjOW8IRnjjSqpAYaR1Nm4Berf3cBA9X+PctuP0DgqVmmzRhvPolJEhcDspTK/ejElt4MaJRtOmJkxwsMyG
    02WA2JL/Db0+FsPPqnKibbdl7vaXpD8J18Nx1yDsmVwBQE/RrUEDshwUwf8QqqnU5kIVC19O8c+Qbxae5byx7NIMFgJuJNMJ/kn05gnwRhnbRAKlB0UzLzU9
    zlVEJIxb4HFgjeTXETMAww==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=m8YGQp87AAAA:8 a=DDOyTI_5AAAA:8
    a=4Q1M9-pzoOfkJi0lzgQA:9 a=Qu0-9XE8Q4HHRmQO:21 a=uwfy6vJhywoQlzJN:21
    a=CjuIK1q_8ugA:10 a=sQmdjVoOy41DRvcrsFdt:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 2 May 2018 02:56:10 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org, w.d.hubbs@gmail.com, chris@the-brannons.com,
 kirk@reisers.ca, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] staging: speakup: Add pause command used on switching to
 graphical mode
Message-ID: <20180502005610.wck7uovcz2twylch@var.youpi.perso.aquilenet.fr>
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

Index: linux-4.15/drivers/staging/speakup/speakup_dummy.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/speakup_dummy.c
+++ linux-4.15/drivers/staging/speakup/speakup_dummy.c
@@ -30,6 +30,7 @@
 static struct var_t vars[] = {
 	{ CAPS_START, .u.s = {"CAPS_START\n" } },
 	{ CAPS_STOP, .u.s = {"CAPS_STOP\n" } },
+	{ PAUSE, .u.s = {"PAUSE\n"} },
 	{ RATE, .u.n = {"RATE %d\n", 8, 1, 16, 0, 0, NULL } },
 	{ PITCH, .u.n = {"PITCH %d\n", 8, 0, 16, 0, 0, NULL } },
 	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
Index: linux-4.15/drivers/staging/speakup/speakup_soft.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/speakup_soft.c
+++ linux-4.15/drivers/staging/speakup/speakup_soft.c
@@ -45,6 +45,7 @@ static int misc_registered;
 static struct var_t vars[] = {
 	{ CAPS_START, .u.s = {"\x01+3p" } },
 	{ CAPS_STOP, .u.s = {"\x01-3p" } },
+	{ PAUSE, .u.n = {"\x01P" } },
 	{ RATE, .u.n = {"\x01%ds", 2, 0, 9, 0, 0, NULL } },
 	{ PITCH, .u.n = {"\x01%dp", 5, 0, 9, 0, 0, NULL } },
 	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
@@ -164,7 +165,7 @@ static char *get_initstring(void)
 	var = synth_soft.vars;
 	while (var->var_id != MAXVARS) {
 		if (var->var_id != CAPS_START && var->var_id != CAPS_STOP &&
-		    var->var_id != DIRECT)
+		    var->var_id != PAUSE && var->var_id != DIRECT)
 			cp = cp + sprintf(cp, var->u.n.synth_fmt,
 					  var->u.n.value);
 		var++;
Index: linux-4.15/drivers/staging/speakup/spk_types.h
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/spk_types.h
+++ linux-4.15/drivers/staging/speakup/spk_types.h
@@ -42,7 +42,7 @@ enum var_id_t {
 	SAY_CONTROL, SAY_WORD_CTL, NO_INTERRUPT, KEY_ECHO,
 	SPELL_DELAY, PUNC_LEVEL, READING_PUNC,
 	ATTRIB_BLEEP, BLEEPS,
-	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG, DIRECT,
+	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG, DIRECT, PAUSE,
 	CAPS_START, CAPS_STOP, CHARTAB,
 	MAXVARS
 };
Index: linux-4.15/drivers/staging/speakup/varhandlers.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/varhandlers.c
+++ linux-4.15/drivers/staging/speakup/varhandlers.c
@@ -44,6 +44,7 @@ static struct st_var_header var_headers[
 	{ "lang", LANG, VAR_NUM, NULL, NULL },
 	{ "chartab", CHARTAB, VAR_PROC, NULL, NULL },
 	{ "direct", DIRECT, VAR_NUM, NULL, NULL },
+	{ "pause", PAUSE, VAR_STRING, spk_str_pause, NULL },
 };
 
 static struct st_var_header *var_ptrs[MAXVARS] = { NULL, NULL, NULL };
Index: linux-4.15/drivers/staging/speakup/main.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/main.c
+++ linux-4.15/drivers/staging/speakup/main.c
@@ -76,6 +76,8 @@ short spk_punc_mask;
 int spk_punc_level, spk_reading_punc;
 char spk_str_caps_start[MAXVARLEN + 1] = "\0";
 char spk_str_caps_stop[MAXVARLEN + 1] = "\0";
+char spk_str_pause[MAXVARLEN + 1] = "\0";
+bool spk_paused = 0;
 const struct st_bits_data spk_punc_info[] = {
 	{"none", "", 0},
 	{"some", "/$%&@", SOME},
@@ -1789,6 +1791,11 @@ static void speakup_con_update(struct vc
 		/* Speakup output, discard */
 		return;
 	speakup_date(vc);
+	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0])
+	{
+		synth_printf("%s", spk_str_pause);
+		spk_paused = 1;
+	}
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 }
 
Index: linux-4.15/drivers/staging/speakup/speakup.h
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/speakup.h
+++ linux-4.15/drivers/staging/speakup/speakup.h
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
Index: linux-4.15/drivers/staging/speakup/buffers.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/buffers.c
+++ linux-4.15/drivers/staging/speakup/buffers.c
@@ -76,6 +76,9 @@ void synth_buffer_add(u16 ch)
 	*buff_in++ = ch;
 	if (buff_in > buffer_end)
 		buff_in = synth_buffer;
+	/* We have written something to the speech synthesis, so we are not
+	 * paused any more. */
+	spk_paused = 0;
 }
 
 u16 synth_buffer_getc(void)
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
