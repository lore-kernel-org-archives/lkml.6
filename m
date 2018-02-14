Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x227qlUIaYO1igk7/N3MjSqgrxUjJ+Chw2LhXOpcdk7wMDncGnMvlI+LizLvHi3JNyA+3E/FO
ARC-Seal: i=1; a=rsa-sha256; t=1518592911; cv=none;
        d=google.com; s=arc-20160816;
        b=e9nZIxVVSUoKcN3sqG36cWigRxJsJyitaRWCepc1LUQOoHeAA4N+U5HeDAw8fnPWUN
         WfzghLh2jmy/InKZ0CWFC3CVGuwGXzeHJ+wXovRuehoA9DBa+soEEZ4Ny81aN2cCHlMI
         QwEaVW8nM51i7X4bSQVAGUI616zbn3ZoTxVpBVyJ1USsbJuc1bYIyyxS/JvmAaom2sPI
         /yNGN7f/UCH2Cydtq1eC7gjNQXTxaP+9Agg2lJ3SaJ35YIHk+UmLbjDd+XRbV8WRi1tM
         gzgNuPAqqwwxEeaW/MJuX0zAn7sKgWSW7D+AeZEJroOzRGT/egrYd8w5KFtta7TpUECY
         FM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=gwGSpcOlJL7Rm9w2f1EXT3ibP/okpZzo5VDdSAb1FxQ=;
        b=DVBQruYVIg2P04TNQGoWfow+DrsMGCdKghUtb2MetobzOCc4IqQXlOUkvb5UMDV30W
         GUH2rzv4N2kXVaBWps7B0eN2kedAueArU+54T6W+FvJgyJ41urulIkflcdzHspon+VtE
         dDFi23XEgHIy0pS621/c1WEToffWAAu3h/C3A7icMLk9GiDXmYkHERqq/vePkoxGO5vG
         tXthcWJHlNqIOUZ/LM8mBnzeIQk2krl4kNlBrU+jOkdg7b8r6FeItTyNLNDpxcdwFpnf
         sqc4gUd15sGq9EWTssd75Ek2gVeKt5GR7i6O5P6Iova/Yj8eeanjPLT+U1uEoiQSOV5t
         m45A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.3 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.3 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:69:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2898:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:4250:4321:5007:6119:9592:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12438:12555:12740:12760:12895:13439:14181:14659:14721:21080:21212:21451:21611:21627:30054:30064:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: pump85_8449a23dc5b2d
X-Filterd-Recvd-Size: 3578
Message-ID: <1518592907.25974.2.camel@perches.com>
Subject: Re: [PATCH] x86/spectre: fix an error message
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Ingo Molnar
 <mingo@redhat.com>,  KarimAllah Ahmed <karahmed@amazon.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>, Borislav Petkov
 <bp@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy
 Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Date: Tue, 13 Feb 2018 23:21:47 -0800
In-Reply-To: <20180214071416.GA26677@mwanda>
References: <20180214071416.GA26677@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592359628754640421?=
X-GMAIL-MSGID: =?utf-8?q?1592360080680928904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 10:14 +0300, Dan Carpenter wrote:
> If i == ARRAY_SIZE(mitigation_options) then we accidentally print
> garbage from one space beyond the end of the mitigation_options[] array.
> 
> Fixes: 9005c6834c0f ("x86/spectre: Simplify spectre_v2 command line parsing")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index debcdda88560..acee4ebec04f 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -174,7 +174,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
>  		}
>  
>  		if (i >= ARRAY_SIZE(mitigation_options)) {
> -			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
> +			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
>  			return SPECTRE_V2_CMD_AUTO;
>  		}
>  	}

Should probably unindent this block too by
removing the else after the return

---
 arch/x86/kernel/cpu/bugs.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4acf16a76d1e..0af8245afb6c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -161,22 +161,21 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
-	else {
-		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
-		if (ret < 0)
-			return SPECTRE_V2_CMD_AUTO;
-
-		for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
-			if (!match_option(arg, ret, mitigation_options[i].option))
-				continue;
-			cmd = mitigation_options[i].cmd;
-			break;
-		}
 
-		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
-			return SPECTRE_V2_CMD_AUTO;
-		}
+	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
+	if (ret < 0)
+		return SPECTRE_V2_CMD_AUTO;
+
+	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
+		if (!match_option(arg, ret, mitigation_options[i].option))
+			continue;
+		cmd = mitigation_options[i].cmd;
+		break;
+	}
+
+	if (i >= ARRAY_SIZE(mitigation_options)) {
+		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
+		return SPECTRE_V2_CMD_AUTO;
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
