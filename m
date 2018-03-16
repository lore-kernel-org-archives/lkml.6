Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsfh75lwJgJVghGyk5wvIet6SyvbGvd4HYHvMbBiNF8uYKYcJyoz2KKbbSWQp6G6jMiFCug
ARC-Seal: i=1; a=rsa-sha256; t=1521214319; cv=none;
        d=google.com; s=arc-20160816;
        b=0mH5YHSN6axQt00UmQggSowLjwNZBp4Yp+q+4XANReFV2YeRSulflebaU4EFE8FHMX
         CIwjbWBvWr9O3FIn5ebXBRLNoH/qnQtIANyT4hJQWXS+0tQSyJ9+aqH2AmbYRy5p8/qJ
         vA6o5f+hdy12p7MF69xC0w3oU7DNRkxtcsgSdh4HeZb5ntbWErD5HJ4HNgwXQcR0QI6f
         gwwR2RuI4mMD2DgePOB7pn3SwVBgzyOD/3/qz9SkYbYCtg3TXk03lZjiWuTWF4f/GxLv
         gqFexsZS62EqyUEmvha7cwrFGLV6Y/D8xe+qoHbfwRnWGAef/svuhVgy3UVRrRkvCElP
         aA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M0Z6M4mnyEYvsj9fJElnO3dRTFFdQOqmcnpLbl8G4hs=;
        b=xns+Ndz8nzeBdqffxmr342oT0UPRxp5vyYqYzD1e0X9ZIN7B8Z6y7xdnOHqmx4HtyX
         5fISvjP516udfe50gHhLektbwnkOWC/X0O27zHjvFiooolppeHAkZsOqm/yJdaY8AyhM
         fWyvkgJfQsuZLFFwbgRaMzHkVOcruantP6onPuBOJX1LdPn+Gvas0sflaGK6SKJlpv34
         QVhyYQmYU9eVKkPLGtvi7i/W5lKyHuBvXOuoGzkSPbnvvbkuptoFWbatz3U0Ndo4Z8Eu
         OJAma7azE0/f4YdC0VsJRfA2J+1GoxZYwuSTzxa0v+kRnAoWuVqjJQtvxah0UDx6nz8g
         ZPOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hansverk@cisco.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 53/86] [media] tc358743: fix register i2c_rd/wr function fix
Date: Fri, 16 Mar 2018 16:23:16 +0100
Message-Id: <20180316152320.963513071@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108576405352824?=
X-GMAIL-MSGID: =?utf-8?q?1595108826822884913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Zabel <p.zabel@pengutronix.de>

commit f2c61f98e0b5f8b53b8fb860e5dcdd661bde7d0b upstream.

The below mentioned fix contains a small but severe bug,
fix it to make the driver work again.

Fixes: 3538aa6ecfb2 ("[media] tc358743: fix register i2c_rd/wr functions")

Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/tc358743.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -222,7 +222,7 @@ static void i2c_wr8(struct v4l2_subdev *
 static void i2c_wr8_and_or(struct v4l2_subdev *sd, u16 reg,
 		u8 mask, u8 val)
 {
-	i2c_wrreg(sd, reg, (i2c_rdreg(sd, reg, 2) & mask) | val, 2);
+	i2c_wrreg(sd, reg, (i2c_rdreg(sd, reg, 1) & mask) | val, 1);
 }
 
 static u16 i2c_rd16(struct v4l2_subdev *sd, u16 reg)
