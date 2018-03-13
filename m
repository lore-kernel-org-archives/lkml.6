Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu18JisEYa25JGQO4N0kNSIbbnce80owpId3jPYUtG1XQ5JltGSSeTrGeI2YKWzrfI0Az74
ARC-Seal: i=1; a=rsa-sha256; t=1520955315; cv=none;
        d=google.com; s=arc-20160816;
        b=TCaS7UnZLoo2kvA7sgJsJeAMvQWJUouopwhdn1ODvDVbvPXtnVN6XGDZIAEQhzldqv
         j3Bm1DmxxG9TJAJFrCzMJv/+QWtEXxVfzko519Kafiya8bq2uXuHg1Fx2O4s1wXs6DpW
         1CTfkeelPKKMj86fasU7S5MXwxHLTvicAvc19Inw6dJz/0ddtXyt5s7bf7qsP+MFufxX
         lDcCqPichionM0inkTbrakz6sAJ5mdPt1NW6qPBAMzhUPG8SrJcJLen2zwnRXyf8KCmZ
         r5eit9SYS44RgxRMdsZ1/+KRov1MJd1zwAumHaSMzZRT3SlT4hRrIochaiFpEHJ0OxtS
         M2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5cj3xWaia00Xbdjk381vZuUfeEAfOvL8DFAoYi14QFk=;
        b=VsatYfe2HioTsW8BGEihfuegTiLBMhiZywHjM1TqlTm7SbYmNAGKW4KzJtmQkQ9nQJ
         hrrsZNtfr59bNKaO0G2Wb0R6qzBRSxMUylBiCotnmpG/fayeoSohEpq4glGtDgk/Uf9N
         /BKP48yS1J6hmPr1vLTnG/SEVnGn0crFfmNQg4qe9lhGE4T5M+7OtAbXfUfUCku9PPKI
         +zQGTmSab3BHRcXy2JzZHCNCr5fTl5M8ns3QbyBMyvXodrJ/jYPhi6kc4CJyatr3jTFU
         2c8EPdE6oCjVZ24TVwnOu6N84ICUNfqvPQpUDJ3zyQ/1L07mzRqWsMXRyKAawkNtjfYQ
         MSyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vinod Koul <vinod.koul@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 008/140] ASoC: Intel: kbl: fix jack name
Date: Tue, 13 Mar 2018 16:23:31 +0100
Message-Id: <20180313152458.694653311@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837240795273528?=
X-GMAIL-MSGID: =?utf-8?q?1594837240795273528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinod Koul <vinod.koul@intel.com>

commit cedb6415f9ece6d3368aa0ac8a433caff799792a upstream.

Commit d1c4cb447a7e ("ASoC: Intel: Skylake: Fix jack name format
substitution") added Jack name but erroneously added a space as well,
so remove the space in Jack name.

Fixes: d1c4cb447a7e ("ASoC: Intel: Skylake: Fix jack name format substitution")
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -605,7 +605,7 @@ static int kabylake_card_late_probe(stru
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		codec = pcm->codec_dai->codec;
 		snprintf(jack_name, sizeof(jack_name),
-			"HDMI/DP, pcm=%d Jack", pcm->device);
+			"HDMI/DP,pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
 				SND_JACK_AVOUT, &ctx->kabylake_hdmi[i],
 				NULL, 0);
