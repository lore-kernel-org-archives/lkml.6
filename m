Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELshbaDQOfoOHughnZm2AJWSq/0J4f80KnCN/sl0WNPJcIHsM334RzKUuf0v997yHmwMVE31
ARC-Seal: i=1; a=rsa-sha256; t=1520955558; cv=none;
        d=google.com; s=arc-20160816;
        b=d5hn8pFJmDB5su1JxywjTie0KyPTF5hoiZVX7b8UsgUXgWTyK0YOg50H0PF8vEXXbI
         GdW8aHsiIV2vM2JZ2TslvNXA0GPlWEP5f1L2vL0ZK2OIVGlYkDtWdgL+qTIMes5hAh4I
         5xrsFpRiv/Kg03SFprKi6JFE4VpKHUM98PhtoxN/dO14zQIihm0pl4UtblGFcF5MBIIP
         ZKkTrvP/E0yeyVUjP/EsQqwvorBXJNX74YIRKtzn2ijhHiLUIIhp1cal2NcXTORY/H6E
         3+gKyXcCXQymOnX1k9OQnL7PSK134/w6Gf3ons1Q84VlLX2HNqRMUa3Te6QUrny8FaOC
         ahmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qEEtOXAZJHOBPrIJjDAi5AjDfCICYYXwZugM04dmcZ8=;
        b=dpX/aspfi2HQpQTq2eS9rzNBtvMt3Ec2rtBSE2jv9jt/fZjg+N5hWSAovtttL+m1ZR
         9rcNUW/mh/rlejWWriG1KyEDCPN/uT+ICDnPICinE9l1NjF5jiZYwUTkagUMnhevUPXP
         1dIg/Ik7cNEOhrlyGeBsRbbTZ6I8QpGZn52mygorU62jxnhGr43MY1jAxUtNL2Mx/jVi
         BBkaqI5D14oThHFUWpJTyJqpV5XW7bsUZerQ/E407COCxdTxDp87EZvqqeHUY97V9Urk
         SuH6NfdACl6EzaRuBJ/J2aNcfM7o4jQeDNOrD1Pj7628GWKcv7zJRzmqSwA6q7Zzc6Ly
         ZWgQ==
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
Subject: [PATCH 4.14 086/140] Documentation/sphinx: Fix Directive import error
Date: Tue, 13 Mar 2018 16:24:49 +0100
Message-Id: <20180313152503.932572367@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836969757914659?=
X-GMAIL-MSGID: =?utf-8?q?1594837496237987915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
