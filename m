Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsr1HCAeX6ZAWoR64iKDdXEUeBtUzoAm2IVPCPB2UVaG3dk3uGFlCQ8m0HqPTMYtgagPhP/
ARC-Seal: i=1; a=rsa-sha256; t=1521214737; cv=none;
        d=google.com; s=arc-20160816;
        b=EpiC3vOhNYG4lAFN5WWG4UfcNU+adQ8wUefsbiI3YDDc1TuBRE0PqAIKNAgqPQHZng
         D0CSgW4WHxQWrDfiTsvSVoFTzIQL8KRiyvJ1dlBD335G5c/k/y8zJye87xn3S/BU3bqc
         KEJlaItCkjIWRnytLjGqcCPjJ8nK57/5EigCDQRAaY5p9oQMCcXLDa71/KLywoC8pHr3
         5BVVkzMx3sWf147LBKy8kJDDQN4oAsrl1Eokl/1fhKZWGpKNgSS4Yw/zPWsyomlhIGDu
         nC8fTwQ7wc8mL/6XiFV/639EVEVDkkzwSdKtODRHwitxbmZxiAZ3HZmC2oJN6P1mRyNk
         o6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B/EbTfL+pfl3ffdzNqqhez8ceTlZucMWb002JRX+YKs=;
        b=CCa4K/P5A61hsIP4BBNyNC5g66XGGKrogaXfLgm1O8Z+dpN7kA17pX8gMHU0sLPP6e
         rNgsdQsXX4+HxssaRJYXo+AnqCfbpnogpc+rrqbyTqiIM4xMg6maAC1mDdcSZYMfn9vb
         FA4zrmtEi/LRQg/bNYj4e84r/nLRk30KB911O/grOjUxPhVcm0mWIJrjSolYKF8pZAOR
         IPqrSDjR32q8nM+x59R2fbv65vtA46QIu4cuC9T17pp1lFycP1I81s+5qBPdB1I8jYxu
         G7N2mOfxzUf4sUwGGjDSpyeg9qRZxSiudpawCn6H9DJU6HtxBEIkEh8KEbfaH/xUmF25
         Z9ww==
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
Subject: [PATCH 4.14 104/109] rcutorture/configinit: Fix build directory error message
Date: Fri, 16 Mar 2018 16:24:13 +0100
Message-Id: <20180316152335.494871948@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109265002453196?=
X-GMAIL-MSGID: =?utf-8?q?1595109265002453196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
