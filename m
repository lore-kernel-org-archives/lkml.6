Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224zLks6j3zvDW4i5iehWEeJ18xC5EwsFIEloYiZsT+8BjjTJZK4taDN4GWY7E1M5YmUqUN3
ARC-Seal: i=1; a=rsa-sha256; t=1519218710; cv=none;
        d=google.com; s=arc-20160816;
        b=wwYewfEghuCMzJH4LhPnOGOjGcw3qgKalkkV+eTnLD/rc+ZSpBjAyyYo4UYcxS7kQI
         hIWaI2xP1GkenCJSi+z1qxE8ZsNch4aAY6GurYcJTPqF22Yx5m8Hwl33LUgWaU/pD036
         WDpg6tLZBEiBe9SrrlUJe/bdEDnmXEMA7mG7LntMXNx2ZMWEvUyMrvJOXT51Z7WEA1pa
         Onb5qItKtunFsG3MitTs8T2bq4eIy70AagB+qyjhNQF5390B3UQMcADrsVLbnXHxd7E4
         /KWIyZSftWTcQtoGb4a/lKUDxnRVheQISzXlq13jrdZscVo+gCWu+2w5pDsjtt30gq6o
         DUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZUrY3YSSSkjDnywBAKXtUpvh8mcYlGAW18Y5PLil7GQ=;
        b=L2Fin+pHSytHDH4TGApxOAJ1biI6CN3lTimLo9qZXyKT0XR2KjTm5Bn7uEVSLLxYj/
         VCxS3zhNC7s1QGnOHhjTVPQRJUCEXGKq7y9hEMvvqrcODxw5KaIJ6eP9WVlroVx1HpwE
         GUF8u3ZDAPMyoyOSj/cgvTWElZ0RV/ZggNcwZuMpLKfxtgmhB1+iy5wYSISI+xkv4ewG
         1nY+H5UrcWkaLhNRc3scbmGYfq12rN9fkmEn8Ug7Y+lwFT7DYwBimN7qkUrU/ko+Xzcw
         SniBy2eJzl9oZXSmRIuB0M826iuW7xrLMIU7YFzNC8lTZlOsR0ozxYbUQvIHIVgn8VUF
         74rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rex Zhu <Rex.Zhu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 4.15 092/163] drm/amd/powerplay: Fix smu_table_entry.handle type
Date: Wed, 21 Feb 2018 13:48:41 +0100
Message-Id: <20180221124535.418440368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015657938599733?=
X-GMAIL-MSGID: =?utf-8?q?1593016278973595371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

commit adab595d16abe48e9c097f000bf8921d35b28fb7 upstream.

The handle describes kernel logical address, should be
unsigned long and not uint32_t.
Fixes KASAN error and GFP on driver unload.

Reviewed-by: Rex Zhu <Rex.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h
@@ -40,7 +40,7 @@ struct smu_table_entry {
 	uint32_t table_addr_high;
 	uint32_t table_addr_low;
 	uint8_t *table;
-	uint32_t handle;
+	unsigned long handle;
 };
 
 struct smu_table_array {
