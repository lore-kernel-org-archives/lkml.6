Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELt6b0XkgeN451clY2d2Yi9Uz4dNys3TVtBxIyYeWwoPbcrhB+5T0FFQDGZ3dhF7Q7xzfK5L
ARC-Seal: i=1; a=rsa-sha256; t=1521141387; cv=none;
        d=google.com; s=arc-20160816;
        b=qmTGnS1Vw0TgxQmmH6hjym0f9U2LXuGGgFnvslYtTlWKtmOfsvSKgKphw/FCrKtY9s
         4l34Kumb32J9+blXUdSiQzkOpKTIuWWUXBJnpS3oi7t4TM9GoSJ/Euxqs5v1e3zr6GkT
         YUyCKQ92f9LybymKbLqELPSCBpGZHxVgGxKvNoq/yCPoolaaxfBURKZUQALGlp7nTWVw
         Ek4mo2SVevcMvB1hrlZxfBtveJDCyKVtwBmWonFrvtkiM88cGkD48ZgmPIfxKFKboNYf
         pO12bFlV7b9BrfOIw7ehzOXjoiwFP53GdPKRyrZpWomdt7wwUcExtGbRrrEaWbhx8dXf
         Or8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0yTnIIBWE7fpy+1xtrqFwpk1aX5ho+G4OYcNFB0ayOk=;
        b=ThanMLOP0RCrKKGFTWKfSBumgKDTm6TWjlW3g1e+8wi3RKzUEqqrFYw5iVD6JBKGk1
         Lrbk4yrmKCRacGvOzf8/dBG80WRL2+jQDdefQfs0GLWSqwKleKmkojFhXWophPBQVJoP
         6B+4HPDuhqg7iDJzQXbSLb6LB+2eK9FArfOYi9mW4bqSpru137Qiy6QY8vijPqoicwEG
         e5PVgvnsxZBDFUuaF2bMml1duxCGODrpnH5WT2LUmncIrZvzxbtd4mQSVp6Wc+6/Amwf
         ZglFx3xF3Eim8Ug93aFKqsmLCQ/gKT9NKfyPVWg2hb1XOjvWN/2uhYannBuPsDIl65sO
         R6hA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Joe Perches <joe@perches.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 9/9] powerpc/64: barrier_nospec: Add commandline trigger
Date: Thu, 15 Mar 2018 20:15:58 +0100
Message-Id: <1dcf7403042daddcdb8109f6b852b9bb9d768f89.1521141122.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032351746751096?=
X-GMAIL-MSGID: =?utf-8?q?1595032351746751096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add commandline options spectre_v2 and nospectre_v2

These are named same as similar x86 options regardless of actual effect
to not require platform-specific configuration.

Supported options:
nospectre_v2 or spectre_v2=off - speculation barrier not used
spectre_v2=on or spectre_v2=auto - speculation barrier used

Changing the settings after boot is not supported and VM migration may
change requirements so auto is same as on.

Based on s390 implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/setup_64.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f6678a7b6114..c74e656265df 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -840,6 +840,28 @@ static int __init handle_no_pti(char *p)
 }
 early_param("nopti", handle_no_pti);
 
+static int __init nospectre_v2_setup_early(char *str)
+{
+	no_nospec = true;
+	return 0;
+}
+early_param("nospectre_v2", nospectre_v2_setup_early);
+
+static int __init spectre_v2_setup_early(char *str)
+{
+	if (str && !strncmp(str, "on", 2))
+		no_nospec = false;
+
+	if (str && !strncmp(str, "off", 3))
+		no_nospec = true;
+
+	if (str && !strncmp(str, "auto", 4))
+		no_nospec = false;
+
+	return 0;
+}
+early_param("spectre_v2", spectre_v2_setup_early);
+
 static void do_nothing(void *unused)
 {
 	/*
-- 
2.13.6
