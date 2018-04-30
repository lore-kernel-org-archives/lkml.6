Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqkPiypevEhqEeQc4z5S6EZRRJdRoryWCL/03B1siKf47rjO6fLZtUPp/c82skFk9/dat5g
ARC-Seal: i=1; a=rsa-sha256; t=1525116499; cv=none;
        d=google.com; s=arc-20160816;
        b=dGJXqvTbDjGjynBOhTxkFaHkVUMBsuHa8R6rGD98P0V6Z+20qccCfpjAGAvcimXvv5
         LagyPv9sXb93jFIp+5zBaF1K4JFjxfSgqA3+7DBqHJdoSl5tpzH9bnrdWfToIOkj81iy
         RkevHimgCggLlRNzlCMM43nURIEtsbK2GIv/NBAGnr5sqrRjj+gOekFIrHx2Diqm5z7s
         0SxRSIM3LdbE/6uqSLNztwEMsdcxM8I99EzabRdSzTxZ74163ONE8QJvnD4daD3nVzUx
         5mmEyCvANA3YPbpoF3o2XT+ghbmQj4UBSnudLw71EZ4NhYEFJKLXIK0jRCon7zPLD+u4
         UtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=I0ftzbqM5rwnA+aw0VPjuYRH1aziiFbZW6MPaQYilhc=;
        b=r8jdLX6FbqVhMxUD6szKXLxhaYvzbd6qIJXsY6H4UNF4pt3Or6bCgMVPUfMcWBacif
         l9BhhuGS6kqyMs7TqnRsSAYwseRLu7mBL9Nc6oRzzYP2nQAO47tPE/HPDnS87JUOqeI0
         l9pe59V+bHEcGIVawV0Jx+rY/jTEp8OsQ7NtjmyHMZFDbeVzwXzyjAj/n4SQzK8d28W3
         HT4YHHP70C/Bm9DaqbwOhk/2NlWpMKHGevdzC0TSyA7HlnO4oNPa8hO5qj+0gGbLnNiB
         Ihhw+IXljMXIoK4P6DYZ7TeQlu0cWgGm5RvNDtClKpNMNCm44IrsisVlItca6JvZxn4P
         sSDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D1A22E71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 052/113] ALSA: hda/realtek - Update ALC255 depop optimize
Date: Mon, 30 Apr 2018 12:24:23 -0700
Message-Id: <20180430184017.263092867@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200496509330414?=
X-GMAIL-MSGID: =?utf-8?q?1599200559004942148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit ab3b8e5159b5335c81ba2d09ee5054d4a1b5a7a6 upstream.

Add ALC255 its own depop functions for alc_init and alc_shutup.
Assign it to ALC256 usage.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7164,6 +7164,8 @@ static int patch_alc269(struct hda_codec
 	case 0x10ec0235:
 	case 0x10ec0255:
 		spec->codec_variant = ALC269_TYPE_ALC255;
+		spec->shutup = alc256_shutup;
+		spec->init_hook = alc256_init;
 		break;
 	case 0x10ec0236:
 	case 0x10ec0256:
