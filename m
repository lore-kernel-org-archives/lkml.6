Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48C1rGQYIT2gZ2PwDlAazG4aJwoTTun4DmS2JZVWiyX0YNukQlItnUUghU1kanV0Uw2vnm1
ARC-Seal: i=1; a=rsa-sha256; t=1522168864; cv=none;
        d=google.com; s=arc-20160816;
        b=PvrRcbkBxgqn1O9gU5sVT1fmfY3UEolqy+cAOS+CuK9yvRAjMuBEDOFQ7EnZRLTZgE
         jWKB59VnOoGxjk1jJUa2DJfy5PMa0UytjPzU7AeiG2r33yIRrYAsBMfoHuGPvBp3Il8V
         xt1VJ93Pz3gTjjbPmj0VnF6DbLSoE0X1wYKbjKB7InO6L4/exaKK66udUD6MkTuciK89
         g8layrtbNOaT+9/UIE8K2ObZIahOcwLZuRP5Wsd/1Ag6xlP2S0kzrEKpH6wAaQnVzVb8
         yVrTcueRzERVnGOfkQiBsjC1HgCGO3y5qjnq6VhZ/fT5OHECMev2pJcXSl9WJy1M/U1F
         ItXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=okcUec4secS0un0tt5i/l/9PMqJvkIggcJ1R0tOtJUE=;
        b=qFFfmseynbM+azvrMj4dHl0UFYt75dHA0Qx+JPrD8mjp9SPDPHwabrf715E2Ea6v7q
         KZmLmTqXNZF8Q/mkXCPISXynmpUXT8q8wQROVJrm/BJ9Bu2W9EybqgSyTSQ4UrI7Xwjf
         YcD0UL2f1D3yB801MiGF/d6Lp8qZrnE4avnRCPWdjx8CBG3RCJozzf7Oqj9STWjfhmuX
         TFL8aDW3uOzCM+aE6HeXqTM0D9VbbetbEKal5ig/1eOSmQCeJLdg9Ex49dDtszQKThHC
         aBvzyNLQFgFayGbBoGQX4T0BsGJ6XxdaPg+6xQHoSuxRB2glPsQ+M8yG1UsWbi8q+xaa
         KzTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Harry Wentland <harry.wentland@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 059/105] drm/amd/display: Add one to EDIDs audio channel count when passing to DC
Date: Tue, 27 Mar 2018 18:27:39 +0200
Message-Id: <20180327162801.150557262@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109738931143357?=
X-GMAIL-MSGID: =?utf-8?q?1596109738931143357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit 731a373698c9675d5aed8a30d8c9861bea9c41a2 upstream.

DC takes channel count to mean the actual count. cea_sad's channels
represent it as number of channels - 1.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -109,7 +109,7 @@ enum dc_edid_status dm_helpers_parse_edi
 		struct cea_sad *sad = &sads[i];
 
 		edid_caps->audio_modes[i].format_code = sad->format;
-		edid_caps->audio_modes[i].channel_count = sad->channels;
+		edid_caps->audio_modes[i].channel_count = sad->channels + 1;
 		edid_caps->audio_modes[i].sample_rate = sad->freq;
 		edid_caps->audio_modes[i].sample_size = sad->byte2;
 	}
