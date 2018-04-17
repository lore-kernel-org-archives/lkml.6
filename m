Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49t8BWUtn952KnCBPsoPdYlULJiEfbLHIe3BFkQ1u4icFULEG49rarGordCKKVJivhghA1M
ARC-Seal: i=1; a=rsa-sha256; t=1523980924; cv=none;
        d=google.com; s=arc-20160816;
        b=hFrGul2ukXwCbetNWBPcR5/4meTocM9H4ZOzA+wBBzrgLBZrWc3w3ZfaplRQw4AUD1
         N2xCuUwQb/7DiSsDYRgIprZlnMCWAcUlhAWwc4iBbODtLSI69eRHjKwvxr4fC/rCNfJG
         OTj/KOlI1u1k+prrn7x796Xszu5BW/oHJvjQblZywrOKEP9XwzLyLAXszYEDMYSQ5QKc
         uhoEwLlMujDjIZ46fLj8LOlgRFNLM5j/o1H7LOuH6ovxlHFt9xfCHXAzhIT4MDdBk3O5
         lubukGu+IVjf/AhXC3D7ZRlfrEhyzbF/cqHgkb2job0RafSuOSgmsRDAXyYeZoz8fZdE
         HPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hDckVAzHPOx4XmPSYyIEU7jiMfpZFCB1QY9AozmsAPk=;
        b=rdUUvPAaPOYmklzXHGvT2jLNEdfSWSph7yfUhXdTbHW1lrV3nmRHEj/ClIihrF2o9L
         9NQ7vjsjijJKBew+hUSZSFMJEMTmsB+9YBCmp70bzXlqWs08XO1R0PUpmh7ZQ+S/kpGz
         Y11XfBgiHGeCAFfHbD5WgOPwRZrxVYWSYx7P2D0NTMtZ+IzjTPOYPf5e8y3bx2hbAmHz
         nRw1/+OBuGAarS33kg/IloiyxSfpTPBKLYthD3ZQkgEX+FmzXK7fdTmA9t01z9sK2SJU
         M1QZSVrifACC3jmkM6kWqR5HCOqH+Kub5qPl78Xzaa6G9+W+BlyqhaGvcBINaCZMh4pH
         AE0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Christoph Hellwig <hch@lst.de>,
	Lee Duncan <lduncan@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.16 53/68] Revert "scsi: core: return BLK_STS_OK for DID_OK in __scsi_error_from_host_byte()"
Date: Tue, 17 Apr 2018 17:58:06 +0200
Message-Id: <20180417155751.504966504@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009822043747766?=
X-GMAIL-MSGID: =?utf-8?q?1598009822043747766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit cbe095e2b584623b882ebaf6c18e0b9077baa3f7 upstream.

The description of commit e39a97353e53 is wrong: it mentions that commit
2a842acab109 introduced a bug in __scsi_error_from_host_byte() although that
commit did not change the behavior of that function.  Additionally, commit
e39a97353e53 introduced a bug: it causes commands that fail with
hostbyte=DID_OK and driverbyte=DRIVER_SENSE to be completed with
BLK_STS_OK. Hence revert that commit.

Fixes: e39a97353e53 ("scsi: core: return BLK_STS_OK for DID_OK in __scsi_error_from_host_byte()")
Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Lee Duncan <lduncan@suse.com>
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_lib.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -721,8 +721,6 @@ static blk_status_t __scsi_error_from_ho
 		int result)
 {
 	switch (host_byte(result)) {
-	case DID_OK:
-		return BLK_STS_OK;
 	case DID_TRANSPORT_FAILFAST:
 		return BLK_STS_TRANSPORT;
 	case DID_TARGET_FAILURE:
