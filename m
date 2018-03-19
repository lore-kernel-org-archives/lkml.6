Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsj/C5H45uem7/gzh7ignt2QUIztKbiJkI0McMbREFbB/sUYGJzNeB4O/jobLZDoYEwz/CK
ARC-Seal: i=1; a=rsa-sha256; t=1521484036; cv=none;
        d=google.com; s=arc-20160816;
        b=VEAmNzZkW1tl0jn/LQgxYos+IPpR8Jj9oIQvUFd+8dXgMnaV0wzsOqZ4YPioTgrxT7
         cV55ExUk5yobvhT40oREiXinM8+xE+aYHsWh+k2qvkvhEiZsRCSHMcgL1UV5q2doP2iD
         pTjPhkG+tftzyX/tZz8QPmDIGq+LvZZMry7AMrqXKXfLMvZ6VDCqDXrp+8lSAx7YxjWB
         652c4GSwWOjrS6k7Uv2f3LhU4Qt/h2MaPlDjorbbeC14k0btmnPjnrlyH4yupp4OdkNq
         +1Jfm20LqOi1cXf6gBWcUo0tpkVwz+lxc3i431X9jvU+9Hk4elrSgzvo6GbOhdqcMK6t
         ogdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M3yT+Pbt8TcdtyoV6nRrTrSsvkms5DKbEfYuN3cwrpU=;
        b=lPAfnHF7PWrUsL68c2sKnmlglXzJi453J1PfQ7sTdNPwX3SawPCLvKJt91QfOhKdY0
         X027HSYXjPO6uPsG0NvAYQp5nSTG+eOqQ/Y6jZVT0fTp0rzicWS+QHC5LEFveD7/qnfH
         6Z2AcSP2LYl82BThEbmiGT8WWPHE0Qq7YUBnBlaAm9eoSUq33PNoPrEvvZaufas5/FyZ
         /IVqcVAf+2Ws5U3x9eXleyaQztBbZNZGuKg5lVEaRt0oeQ7rSMPxSYDCZEMlQ5eCkMQz
         hKgbCdARKPWDV7eBvgq29DkbwUyOZMwsR3z6sxKOes8AoTnsC1VzhVs+6ABulqzgy0Ez
         4MJQ==
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
Subject: [PATCH 4.9 207/241] rcutorture/configinit: Fix build directory error message
Date: Mon, 19 Mar 2018 19:07:52 +0100
Message-Id: <20180319180759.745131675@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390637326267892?=
X-GMAIL-MSGID: =?utf-8?q?1595391645199535223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
