Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AB8JxZpIQWptlxLNB31Af367H6XWISCXlBbqIWxgtUIDayeI6r5OwkL79l0TMR1LV+Q54Q832KM+
ARC-Seal: i=1; a=rsa-sha256; t=1525978228; cv=none;
        d=google.com; s=arc-20160816;
        b=JuGqKIy9qUhXH9CiXaOzmYMIV+CNuEl0S2iTxsugB6J/rK4NtNQ1WOASSV33CGsgq+
         bsJKzvrTAmiiBYD9n98VRuLp5JmM9d3+mirNLgFVp7sdhEytb9Sg58Zuwp4OviXVtBZb
         Qa0N6CrkZdjz+L6QC+Jsir56ZHjlGiwidrudWdfHGkgkVrRX7DbGBEf57BrfePZe9B2D
         WitxBAvBxU4fRUrzArelRqiF2+Ycqq776ks1so4PKoWQUWGmBoY9pM5n6jyHBLHl06Xw
         UkMDBVWE21VlQM5zBlFDaBbFJmFZrhsMvEbkedvLFq9Ghh1FXNUun8KK1ny3Uq5NkjHX
         CPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xpc010XgTK2PzOLDKZf/dmWhCBF86ki0WlbzP2tsijQ=;
        b=Kg22VHUtS1arQUXh4lauDTpWyCbvKUnQfC3I0OkESWzJ/j7bjSVKbg/nJoFGIABow7
         +Qy00XLqD6zJhCb/rVcLONODQcZ0ixWm+cR0HC0k0A1EI4Hyj/dFbkNRYczocv4PwB0J
         ntyzhED9VMN6ds8kXva3s+2AxZqi637chmoSuXzLXHu+mCWr3HVpKZ1RKJmjflV4oRzD
         Ry1NFnjGtyefntGzQYg+K1A6UzD+KZMo8doLqZcLOJEng3OcbsVoZzBnHkcnEbjHtBwF
         uD1MsPL75SFCgkzgHMsc4nFd5tGA4Ntt0qhxCmqaA2AMsJ+DvzYrma/yCrOx+tCqg1wl
         6IUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=kNILpPok;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.84 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=kNILpPok;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.84 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: wHyNIl8VM1mOwLzfbnihFTbRFr2AIskSB7kppyCaC5WZL6rn.sfVM9Gg182lm23
 4BBwwUQBI.EtfD0YDLY76RarudByQmKJ2j0KSh1fzweSBJgT0T0U_NLRgT52uTK0zMvEUfyS_mwQ
 SDOkJ3aBYviq5q5Z2DIP1n44z6l4AsFvgcDTD8quQVRbOtpaIGoGV0oh67zYQFO0XEOfxKrRXSLc
 4SMO0B9pJAuimVPxUguOYnhKLaU_D3lPOI7mh18.NIT51e5k5DrdRORE6xvG2J_Qu36DNYy6PMvs
 474v3d23NeX.0sIq8fk4BZrbHSmgT56HiwO8NfeNpOlvWOYGSxl4F24TooTUVK_YdK.ohMz9wCPk
 JbWsS0kxmWRYmYr2HJdZjcU3pBUk8czI88PhyV2.fgXWzq8jyOY6_IO7UZpZ2kZI66Q08AWEAVDr
 qguppU2NgPMNElIgRhLyFecrb1fapGD7k4V3mShmixcBztD7wWDsA0qRgnkEF0Z5qm.MeQ4ExzBT
 EIqqOAdfraBnMKP8T5Vsi6Ydw9Z.CHoHfX8HWNijtWxIhu8wTyULQMgW4_l7Y1ZLKjPoUrRKSOap
 1PSmS6XZJgB0sOzqp89adUTTlvrxcQ0rMtiNQdseEBodwQkktBqfs4evk.l9ytFYQ4yB5VIc15t3
 wlw--
From: Jeffrin Jose T <ahiliation@yahoo.co.in>
To: shuah@kernel.org,
	kstewart@linuxfoundation.org,
	daniel.diaz@linaro.org,
	pombredanne@nexb.com,
	gregkh@linuxfoundation.org,
	thomas@m3y3r.de
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrin Jose T <ahiliation@yahoo.co.in>,
	Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH] selftests: intel_pstate: Fixes for the testing script for Intel P-State driver
Date: Fri, 11 May 2018 00:19:29 +0530
Message-Id: <20180510184929.23926-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600104147231602763?=
X-GMAIL-MSGID: =?utf-8?q?1600104147231602763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

fix for notification of permission requirement to run test.
fix for exit status value for test skipped.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 tools/testing/selftests/intel_pstate/run.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index 6ded61670f6d..4ddd389c2cb9 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -33,6 +33,12 @@ EVALUATE_ONLY=0
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+msg="skip all tests:"
+if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
 if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
 	echo "$0 # Skipped: Test can only run on x86 architectures."
 	exit $ksft_skip
-- 
2.17.0
