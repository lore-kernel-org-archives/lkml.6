Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELujyAEx1yzzXR50TcfhMygJeMtG+hE7VwbQUU7kutfzF/GdhTBu80HPFJtrnDY+gzB3FP4D
ARC-Seal: i=1; a=rsa-sha256; t=1520955056; cv=none;
        d=google.com; s=arc-20160816;
        b=dZ+Tr3VOj2QxYBbFTlTMZvCwemcfRZ4PFx7anUJ0euJElu+uhYhXjGHfutQTY/6wKw
         PPUmpSfiOE6a7a/aw8HU6o77X+0GbkVGJ1okd3zP/umz8yq3bC7gNC78XAflL8ceb5Bo
         xaj698GRe8p29PfxugC6LAJffZ/FUPajGpmkW3074lxPzwu2329YY5WsRdJ1kguHPkkC
         aTm1I0Zemc7VZeCghVdtSEEgb3hlYK8JuRX8xoG4PpCWz9IVeE8NqFjv76PLuLasp7lO
         KaJQImi8mezMXZHAtvaldgLGJBfQz7YqODm36iq4PTlKJgiCRhwx2Rg+BxM2L4BvqSP4
         N/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Hhccz2K6nZLlrRyeZc0pjmMAW53Mep5X4/7EFRZvmEE=;
        b=wWez51sB0s09B+ANz7JlyHXF/6uKN+yo/mxPyyOoBZbHRB3ZgNoBxUwi5GQfpPE/WX
         OiHtz4K5FjvQUyipAnR+tglNzJ+ewefxo7wQ3ufDqxVgfgcsJTffowqF0IIx6FxT0ETd
         4w6XK19ppirqpjUR2XLBU/bjzVxVVgc53nCDL/hxRL6p/SMF4FRKtEuV8HA5OYVX3AY9
         UOu6r2ltwdWHrZbDTDhxg4WEgp7H/aq6iUaWs107ncsDyTyTm19PIyO9p0qk5Ca6egdJ
         D2tcXSMhhx2wCZBvd05MT0lhXaxHmLxQVEk2GxXr/GKFxSxfqi1K46DjxCRosNZG57ij
         VXWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4.15 050/146] Documentation/sphinx: Fix Directive import error
Date: Tue, 13 Mar 2018 16:23:37 +0100
Message-Id: <20180313152324.512457634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836969757914659?=
X-GMAIL-MSGID: =?utf-8?q?1594836969757914659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit ff690eeed804f112242f9a0614eafdf559f9276a upstream.

Sphinx 1.7 removed sphinx.util.compat.Directive so people
who have upgraded cannot build the documentation.  Switch to
docutils.parsers.rst.Directive which has been available since
docutils 0.5 released in 2009.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1083694
Co-developed-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/sphinx/kerneldoc.py |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -36,8 +36,7 @@ import glob
 
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
-from docutils.parsers.rst import directives
-from sphinx.util.compat import Directive
+from docutils.parsers.rst import directives, Directive
 from sphinx.ext.autodoc import AutodocReporter
 
 __version__  = '1.0'
