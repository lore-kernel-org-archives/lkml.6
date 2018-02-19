Return-Path: <david@lechnology.com>
X-Google-Smtp-Source: AH8x224jQbEdUmB89WvU+Xg9vGjV2NjElvzLsMaElUTLd/KmOIiwhZstZt3EHreRVOtMmXUBZZU8
ARC-Seal: i=1; a=rsa-sha256; t=1519076586; cv=none;
        d=google.com; s=arc-20160816;
        b=FuRESya1c87xRLx65mw3BoYbWKmQVCotWPuGqnY3Su4HnrBstPB8nRbW43oLUcyi54
         XWSZ+CiLJHspdNfOZDs9uy0unyXiufRvpNZdc/7ZK8rkkoFZhJuDhslk20qUOPWE/gIZ
         OSYOE1jeDc6SzVzedVw09bcxY2dNPhaFRvJ62eDX8GOSojROr6rSTAOxkHZkSQZcccWb
         4Gc2Sv+bXYTIFCdO6NR0Di8ySFzjMsgRbGnIKX0XnwCoPeUyhQ7hglUj9zDsw4IWDARA
         h+vQ6mJ6xojD7mlKK4PgAfLsawNk8XwIHTj+vy1HzDo5hFQAE4by5pGAL3sHqZhDGWFs
         hYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Jy0vRDOmkC5b4B1rhtenYxtGCrqPIPcLT0jtIQHU+nk=;
        b=wFhYE84SRxPK5VvoROftnBVmon8G4sMLiBAJbnMbnBUAWCz6ZwoyQLwWAZ9dlPAFMp
         AJ8kt+iIQKLgnqZ+5Mcpkn15n6LNw7nxoDgE0KMmZt4CdEsOB2C2FBbpUUcCRmiRWBz2
         Z/26W6+pFk+FmuF94ophHZsRsDNtgW0v+q929fEIYkfsl48xNdbuDx5UmlQC/dDAJCKG
         xwZBiTWAfYcf5XZAAGomcpoby0nPI8Za6g3N/T85/SEv6o/vmH7wx5MBnfKfgG7qlpRl
         qmszNlMgXtsXIHNW9uIychLTOH308BEYWgA5iFx05C4bcWJug4v67FqAl9YUPlXnJJqm
         FrnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=pBhFZiw0;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=pBhFZiw0;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
From: David Lechner <david@lechnology.com>
To: linux-kernel@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/2] regmap: use debugfs even when no device
Date: Mon, 19 Feb 2018 15:43:00 -0600
Message-Id: <1519076582-7687-1-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592867251259492596?=
X-GMAIL-MSGID: =?utf-8?q?1592867251259492596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series allows regmaps without a device (e.g. syscon) to be registered
in debugfs.

v2 changes:
- address review comments in patch 1/2

David Lechner (2):
  regmap: fix NULL pointer dereference in regmap_name_read_file()
  regmap: use debugfs even when no device

 drivers/base/regmap/regmap-debugfs.c | 6 +++++-
 drivers/base/regmap/regmap.c         | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.7.4
