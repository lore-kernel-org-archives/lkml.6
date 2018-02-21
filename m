Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226aqq/GNcB9ZH8kx2alztJGveQ+OkdJ0xBJK/e94HaaoYDFe46wFTBJu4j1VXYHpNIKze4r
ARC-Seal: i=1; a=rsa-sha256; t=1519218663; cv=none;
        d=google.com; s=arc-20160816;
        b=JmAVOudkM7vmBw99XiPTIWtTxs9emJw6eEyZetZOp9J8YUI7TCSL1+FOHY+0s9Uqtd
         2+L2L9vHrgn4dO9bnn5tYB8i4XaI/JZmawtkF45RViNbCBWoAasbneWKqckRJXSbxCQv
         xFdCs0YTirxMiyp+nCA5fO+VPVJ0bz2RnRutBj6OOxgmU4ot6KweN2Fnd0LFnV3OijP6
         Ntr3Zy2wnKWHNFgQyWoCjCtGVFcWGGSdLciPCnTmYZdzkj715spUGKkgj4kIbTmRiqJ5
         B6dLkEwNs7QbdgMj610gyxW0Dx8kDE6iNZTB4uzUTZ/VacIqa89guDQFZgPRZy4sQ8EE
         vEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V6QiCeE7nCm9hVNK9hW4F7ccC26Ir9onHOV7poqJXFw=;
        b=EmeZlbpq1MfoU1YmKFhnBPL26rTe298zwYHfzT4FfQnIHtl7TAwJ10hgvZ1W3yMiyI
         AHAPqD5hryflr7GDut3Ph+CfKQFbyRa1c5SDFGZOFzlo2igo61EOx6eQN38oT/ENmGeI
         a0IxETipTk2V1mYRZlHv9gzHWWD4c0rxIapYvZMa2ctDtfbrN5vYRgCIBiTp3tfsfeCE
         70hUwjDzAN2fZEtvtWvpTk3RBrzuYX6J8+aqhpXUFlvhjom519G+dUsslAM73xQVYfui
         wqoWAmjZa4D+0mHr7kpjVNeWD2AyqeObUUopOK2OxBHYgeiZ7mhDLZG5XmHVNZgQ1FsX
         0gfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" <ernesto.mnd.fernandez@gmail.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.15 109/163] ext4: correct documentation for grpid mount option
Date: Wed, 21 Feb 2018 13:48:58 +0100
Message-Id: <20180221124536.234378326@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015282752811367?=
X-GMAIL-MSGID: =?utf-8?q?1593016229747409249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

commit 9f0372488cc9243018a812e8cfbf27de650b187b upstream.

The grpid option is currently described as being the same as nogrpid.

Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/filesystems/ext4.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/filesystems/ext4.txt
+++ b/Documentation/filesystems/ext4.txt
@@ -233,7 +233,7 @@ data_err=ignore(*)	Just print an error m
 data_err=abort		Abort the journal if an error occurs in a file
 			data buffer in ordered mode.
 
-grpid			Give objects the same group ID as their creator.
+grpid			New objects have the group ID of their parent.
 bsdgroups
 
 nogrpid		(*)	New objects have the group ID of their creator.
