Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49NsfQGXIiSwnvg2n0Ol4lPKg2S8Lr5YNZolYbvsi9Oj9nQ0DH+xga8sfzdtX0FCLxWmxnJ
ARC-Seal: i=1; a=rsa-sha256; t=1523021575; cv=none;
        d=google.com; s=arc-20160816;
        b=e+mpKTd70slNehWlidNFDwzP1ARUIaE7OroXsmE6D1aMfTjK1MwolHJr8LZ7D6Wj6M
         tyN8CSRP6FviDwgEaH1TIp2HRJEFU9yzyw6dKdW8HhHYhXvz/wElbsRixe7wadht8XAB
         BR4QoX91bgqBAH5QVjpLXx9xkdo8qOaAh9OJBqzgffgg08H2NbD4aZ+uTr+GeGi5Rft2
         jr/dIj0r6znBWED996smd4DejfaZNapctuQLjdYazQksgGtvRRKB2Q1dn9c0591Aq2zm
         XXXcSv7kq8FZAcsfRjzkeGAojHT9Mfu294Mh9/WP6FwB+IUHh3SCNJKIByKNBIRaR9do
         pH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dv0jBopd4ODG90GbyjbU6K8CMf9mX5sm+kCUjKIoyNs=;
        b=iXqyTnNUyRtj2zBLxKbZR2Y2bS4eYR1XIWILaxi7wRv2DEWIspfrUfOJOZrtWbDuvX
         n+xquY1mJaa1acLwKqe4DGv0Ph+0aDJ5FAn5n0XTOTbqiZ5n9Q7JV42lZnpWOL5rhCoY
         jgC5EWKqMLuYEIc7g5cewRDUTP7rqUX18f4Ax/mWWAS+f4mFD9lqna4SvWk4SBCCQt/M
         s49aQttYW9yPGlt6uohvxEY1ohIr1e/tQqd5lnwfiytnW48KACvPV+voynUps8O88HLG
         CBgjYFzkmXiGrCHPTk4JzA9IQGE1b5DGrXk3OH0cexnnFatAGValmqd2+qzURBLPqmoh
         qeEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Mike Snitzer <snitzer@redhat.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 014/102] dm ioctl: remove double parentheses
Date: Fri,  6 Apr 2018 15:22:55 +0200
Message-Id: <20180406084333.638740688@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003760341389885?=
X-GMAIL-MSGID: =?utf-8?q?1597003872260658028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit e36215d87f301f9567c8c99fd34e6c3521a94ddf upstream.

The extra pair of parantheses is not needed and causes clang to generate
warnings about the DM_DEV_CREATE_CMD comparison in validate_params().

Also remove another double parentheses that doesn't cause a warning.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-ioctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1777,12 +1777,12 @@ static int validate_params(uint cmd, str
 	    cmd == DM_LIST_VERSIONS_CMD)
 		return 0;
 
-	if ((cmd == DM_DEV_CREATE_CMD)) {
+	if (cmd == DM_DEV_CREATE_CMD) {
 		if (!*param->name) {
 			DMWARN("name not supplied when creating device");
 			return -EINVAL;
 		}
-	} else if ((*param->uuid && *param->name)) {
+	} else if (*param->uuid && *param->name) {
 		DMWARN("only supply one of name or uuid, cmd(%u)", cmd);
 		return -EINVAL;
 	}
