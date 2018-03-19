Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv7PW9+TJssk+VQNruxfQ+iM63ljEobuuR8HIYiWvQckP79EnPsK4+7vdKbjvVie1EvheFG
ARC-Seal: i=1; a=rsa-sha256; t=1521483489; cv=none;
        d=google.com; s=arc-20160816;
        b=Wfn+ZEX6BH9aZYCLwcJrPpgRccMHvRRxf4B4FIKeWRremONa4FKW7FEOfHYRvKwiud
         ZGlfJ8YZPJVyyIgCxZ3YKGOzbEutBtv42q+N7bZvivRAI82oIVXoWQjP0fdfTKgyumhF
         LV6n+QBX14b0VDCY6cG0QN09XaQ4xtnrA1Fxjn+z/75x/nM7aIBiz4SqRNosT69gh3xx
         ek6x3+jkDf4eajXHywzXzUJNOF8OWLQ98+qePyPhzxG+AMAe7KqqMCRCmtCgMbJ1dFmF
         zZJ9sC+nzAlDDSNwwRx21hMfaUpkqlKyaF0Iib+5jdvalehizuS7XwRxJnE74YwOzTOc
         CRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JlILj6RgkRPnhKYO4qxmWOF5pmHo41g2Z/5DRs/8bNs=;
        b=qeRGNwWsubvOFgAks6IwsFDKBiq63Va6W0GmbafwfjbyowkYj0Pxy25ZYbLRiZ3iAZ
         oF41xlCsOUHsH+NYzrlH1jZPfaIEs9oxFvRsOlAJcQbb1cjFbKmmgWZSH0pJNGNSFCYz
         HQICFm5pSdX1MQQXtFvbnnSRADBcUp8+4Ok+oLnozGx7DDlpPWTXos/SFFOS69uOi0Dv
         681OlXoKE9kn91w+1b+Hpvz7Ds3BkF/BeeEMj40oJdxOnNiVZ0+qKJ/t0kF6VSzxOIPJ
         iWf3lY5m+mPBH7AivJ7p2C5DQvnERXXgByGCMZB5ia/RvPwVyRvhLCMODRFrHlovca/I
         JDdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	SeongJae Park <sj38.park@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 108/134] rcutorture/configinit: Fix build directory error message
Date: Mon, 19 Mar 2018 19:06:31 +0100
Message-Id: <20180319171904.844070036@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390637326267892?=
X-GMAIL-MSGID: =?utf-8?q?1595391071571144199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj38.park@gmail.com>


[ Upstream commit 2adfa4210f8f35cdfb4e08318cc06b99752964c2 ]

The 'configinit.sh' script checks the format of optional argument for the
build directory, printing an error message if the format is not valid.
However, the error message uses the wrong variable, indicating an empty
string even though the user entered a non-empty (but erroneous) string.
This commit fixes the script to use the correct variable.

Fixes: c87b9c601ac8 ("rcutorture: Add KVM-based test framework")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rcutorture/bin/configinit.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -51,7 +51,7 @@ then
 			mkdir $builddir
 		fi
 	else
-		echo Bad build directory: \"$builddir\"
+		echo Bad build directory: \"$buildloc\"
 		exit 2
 	fi
 fi
