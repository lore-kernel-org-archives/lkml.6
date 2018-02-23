Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226aCkrsEmWrpKZLinXayJdZF+PKBqs/t350/gXcyAWfeCl9HKq5i7Vp3X7V2jb6MEM6ZOjP
ARC-Seal: i=1; a=rsa-sha256; t=1519411182; cv=none;
        d=google.com; s=arc-20160816;
        b=0vkMkfgf3P/A+JgNtUsAvO7xfpG9ILN3IvktApKTDDn4qSzSDIl7L5rQKS8wpKuLiI
         gzF7RsHIKY5rXco77exeCgQWmoZr7EIKquC+lJ5FZh/0Xvt/tdAZQnVN2CC9u1uFsapn
         O63WcEk4xZBiTNgIXaYTNMCW0fwhojyuNTz6iW3BuHZtJPC6P304Kf+DE73SFVZ9l+GK
         h5oQzvi/ycOrYG1qDlsz4tBwh17Md2BOZbAYlFDcf9NG8KEKeqx5e8LZc89WJUKkLUB7
         jKO8XKceYBJXyaCdrXVxJTGnvwqXWIMtU+fWtTwHoaucry/bwnWlF+On+Gi+7u8UeU/8
         SSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qLIEksqOBNJ+3s29vTkcd5rfa7+Qv6O9zhiiRoAgF10=;
        b=cbpAl7Y1rPvBf9lEOKP4ejV8Z/SR5CUjzN0xYVFPv0LwP1J5/6Lk1KrGTJWEhIDlcW
         hy/6fnjpz3bDw64v0YQxplUxj+tejdeO+QzO643wPjLyLHGvVp+PCXn7Gye0b8I5EUT2
         2x0BZah3w5ZcmwdLpoZSaM945d/beiOhkZBWnNw9xGHnLkfHRetlGsRmoibCuxn1qX4h
         9iWOQ937ZSmUESf64j/CbKxul1yiHHnr4Zx2UINiolb6WXMG/Nb+v11thGsqCBA2vzeB
         rm7jlBdgyGP0WZmLxfn8X/Y7TOKnFooverT2+uPP5lDx0lhMSs/cNgN5Zy9aVc78ndcA
         qxYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 148/193] ncpfs: fix unused variable warning
Date: Fri, 23 Feb 2018 19:26:21 +0100
Message-Id: <20180223170349.066404744@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218099827168839?=
X-GMAIL-MSGID: =?utf-8?q?1593218099827168839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 9a232de4999666b2e8ea6775b2b0e3e4feb09b7a upstream.

Without CONFIG_NCPFS_NLS the following warning is seen:

fs/ncpfs/dir.c: In function 'ncp_hash_dentry':
fs/ncpfs/dir.c:136:23: warning: unused variable 'sb' [-Wunused-variable]
   struct super_block *sb = dentry->d_sb;

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ncpfs/dir.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/ncpfs/dir.c
+++ b/fs/ncpfs/dir.c
@@ -133,12 +133,11 @@ ncp_hash_dentry(const struct dentry *den
 		return 0;
 
 	if (!ncp_case_sensitive(inode)) {
-		struct super_block *sb = dentry->d_sb;
 		struct nls_table *t;
 		unsigned long hash;
 		int i;
 
-		t = NCP_IO_TABLE(sb);
+		t = NCP_IO_TABLE(dentry->d_sb);
 		hash = init_name_hash();
 		for (i=0; i<this->len ; i++)
 			hash = partial_name_hash(ncp_tolower(t, this->name[i]),
