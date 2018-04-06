Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Jg/ZKwc8ktVAtCe6jZKmgy4YbXx9NBoK4XnNmWPl9WXVgvOzStQ7vMT08btPc8dl6lu0k
ARC-Seal: i=1; a=rsa-sha256; t=1523021333; cv=none;
        d=google.com; s=arc-20160816;
        b=FfJgVeutFhKVaN8g05wc+pj1K2bjoRF3OEoL2R+WtB1RS+xZgD5dLt5MAfkSmELZLh
         1kwVyiQAVe3M/QQC1C38YsGYq+O8omx3hVvJOUHWDMtYq2zKLsqtdIbjFaG3dlQaugxC
         UPxqbAUeLHZLU3TEj5VzDglnDCAEkmdjLxV2vCJP0zNn7HmOZzAR9dDgp4+EGZxnQ8a2
         6w/QDccxuUWt3y0mFxkGE8OT96YS6OBb3Q8wCXWGwp8MteX6MmSh2MhkM2XQsU3FNMGI
         A48XHaNmG9Bua59hvBlctubTCU/t7PKSq4GQ9/l/JsjnBGqDKfPM9AdSNJh+1Phus26k
         6ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ieuzd0/veiFe2LXgSgWxQiPFn2z5Wzds9kUydNyLrkI=;
        b=dPjTo45xOuYJCYww40EMfO/Rbw00ehfWYZWXoY44Oc3sk2ubJnBOBeG9QjMZW/jZFV
         FNzsk3p7IBt/ESNU/ON502Lln3161JliIbmcSdH449tg5tArWCUVXqQR6JrPQz08+VLZ
         SKYBeectwOZ3CntHHysCqWJKvUHzrvYt0cmlU1AnJ5OsmdPwW0SIp1/5EToSWWu7QflL
         6ZmxkcC7A0Cv0uvYm26YqsiUWT45RBqm0rFWu6G5Fq2p2vDr4+rbvtIUztGQjEgCdIrR
         YyOajzgs5HCFhUhPWGu95PnMqZBA9HCAcM9EzTXRHe0PjJjK3P/st1v64FF0GfHCq/s/
         J7BQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	"Andrew F. Davis" <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 93/93] Revert "ARM: dts: am335x-pepper: Fix the audio CODECs reset pin"
Date: Fri,  6 Apr 2018 15:24:02 +0200
Message-Id: <20180406084229.224869344@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003618153570477?=
X-GMAIL-MSGID: =?utf-8?q?1597003618153570477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 2d8c5aa6dc436f6fc1c8b6c0feaee4b0f60cdf38 which was
comit e153db03c6b7a035c797bcdf35262586f003ee93 upstream.

It requires a driver that was not merged until 4.16, so remove it from
this stable tree as it is pointless.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am335x-pepper.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -138,7 +138,7 @@
 &audio_codec {
 	status = "okay";
 
-	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	AVDD-supply = <&ldo3_reg>;
 	IOVDD-supply = <&ldo3_reg>;
 	DRVDD-supply = <&ldo3_reg>;
