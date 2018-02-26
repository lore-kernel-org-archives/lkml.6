Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsu7mjcpRr9BeoHN7C36+slExsLPAjXATupSOGYI8fTsghXQSxh+2Su0Za7w5VTd7/wnZ9u
ARC-Seal: i=1; a=rsa-sha256; t=1519676714; cv=none;
        d=google.com; s=arc-20160816;
        b=eqWoexAmxwYn7uT7tsrjDjAwJ0jySlU7Jt774aEU7g6ISxegwZ+5eJzIyFtW2uHcTG
         wUofMQMJ/fWZ3O1/nRwN1hro4tC1Hvd3amKZEdPuGSijCAgN82bAORJ6HaqSpx8JT7FU
         d1/WNMACd9t6Q+eKBLWm2vmabo6YxkpS955VNMTP7xYQOg95d+ZSq9yLI61DVgzk6OzW
         AwOAEvaI9vHVjYI+SPQqEnz1iR/NrrXnWyPalZWdHTCFKrl9T25A+W4kqlSuxtLvqA7h
         JVhqSX5aVOgcU7D33NAhiQP/MovThfFh70gInVpPseTo6DQACOjqdlZ1bo1v8YNy2uWA
         O5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tYP5e37uVqPW7mmh6pSqsGdQO1GWcbkY4whJfTw5glk=;
        b=SVZ4M+qEFiO52b7gSdR++EIqI6RNt/c3ePyf7EULrSQJw59oJsKcaZTbtrFEyryBVs
         NRtTIHlD29Up0WAtaaW02eb1oMTj71YIX75/nC6MuQY0dKB4UtO7BNeVpeaGx+zl2sit
         jwgKaVSBI93Pk4/bH03FTBTxADXMTaq7NWG22ppAmC3tx2zGDWrgbhkcrkPrsYSAt8Cv
         3885YsUgcg50U+2WQLhVmaooJ4iH2QF9KswPxpEUCzOvaoagfW4tW/j2h0qKwUplyMgj
         zL5E49Y7Xgy11+7Ild8GPOT1Nag3ltnDB5p3DK6PBw46TTkyEeFXkuyiiFd9na/5/lAl
         JZmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 48/54] drm/amdgpu: disable MMHUB power gating on raven
Date: Mon, 26 Feb 2018 21:22:25 +0100
Message-Id: <20180226202146.910642060@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496531110567555?=
X-GMAIL-MSGID: =?utf-8?q?1593496531110567555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Rui <ray.huang@amd.com>

commit 400b6afbaa949914460e5fd1d769c5e26ef1f6b8 upstream.

MMHUB power gating still has issue, and doesn't work on raven at current. So
disable it for the moment.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/soc15.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -661,8 +661,8 @@ static int soc15_common_early_init(void
 			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_SDMA_MGCG |
 			AMD_CG_SUPPORT_SDMA_LS;
-		adev->pg_flags = AMD_PG_SUPPORT_SDMA |
-				 AMD_PG_SUPPORT_MMHUB;
+		adev->pg_flags = AMD_PG_SUPPORT_SDMA;
+
 		adev->external_rev_id = 0x1;
 		break;
 	default:
