Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AG47ELvKhYJW2asNwndgeWf9W1gunnLDOKlmberBA2hD5r8BwP6NqTvkPLPl74PqDXDILa2ZF6Ni
ARC-Seal: i=1; a=rsa-sha256; t=1520371352; cv=none;
        d=google.com; s=arc-20160816;
        b=aEEYJ3aFhfuIevdg21tC2gecA0zvaHUD94kHJOLgQDYb/Tgmg6xt7pxGLz7lH8tiCw
         058klykJCqWD+43KzzralhKF0BdxgImrHkTcC4Yw5/aLlanJvDe9LSs93yfmJuxHh5yB
         X39pnFcPDsSwR0Q6DmAUB+Q6xZVhP0yuNdXQ+/yQrXEhnk4BiwzmYBneH62+HTrcaLQH
         s3gpKU+phg9wiIhhGsKY5LFliSxijXow+Ou1zPZTOIfA0eHTKvMIjLRDUMDFDUIaVLvz
         FMMrTQPwyu4jJyT7uD7InCHajZ8nWL9WGijg6xYP7IxWsDYNmPxSfUMD6m8ac1hSeoao
         wxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=FAeuliIsLghfd/WbXBIrsozHYXzpwcgD5sSWls66X3A=;
        b=w+3AYoK+cOCnyo0yL6W5igd9nJ/mIwvwXFwOe/nZRsdVPDYy/5gQ4mMjux+a6wagup
         dKzdplnz03HDt98bUDj0NBsRVqbEnYm+VamHPatd6fnnvngRelvHj+N5P/pnXa5g5Wks
         NK9A/gESzfwfwD6COeXvLVsXkuyZRKiQ0T3XZ9I0HNos7ar3WGYWGpncbEIxmEYRDb8S
         UP5GReK2b1TLIzRY2ol4oG4RZnAXqGFx5d8EalX/2NOwkwvu0JOznAnSwRvHfLviyHkA
         PAtsBtCGoQRa8JO+Gy6JPyD74v/VW5MIvY85D2X5DNBeSpHZuv3gm2fDlro3uRMhyuQY
         IfGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1520371350.23626.23.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 03/34] mtd: nand: gpmi: Fix failure when a erased
 page has a bitflip at BBM
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Richard
 Weinberger <richard@nod.at>, Boris Brezillon
 <boris.brezillon@free-electrons.com>, Sasha Levin
 <alexander.levin@microsoft.com>
Date: Tue, 06 Mar 2018 21:22:30 +0000
In-Reply-To: <20180302084436.171257760@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
	 <20180302084436.171257760@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593815412959122192?=
X-GMAIL-MSGID: =?utf-8?q?1594224911183387647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-02 at 09:50 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> 
> [ Upstream commit fdf2e821052958a114618a95ab18a300d0b080cb ]
> 
> When erased subpages are read then the BCH decoder returns STATUS_ERASED
> if they are all empty, or STATUS_UNCORRECTABLE if there are bitflips.
> When there are bitflips, we have to set these bits again to show the
> upper layers a completely erased page. When a bitflip happens in the
> exact byte where the bad block marker is, then this byte is swapped
> with another byte in block_mark_swapping(). The correction code then
> detects a bitflip in another subpage and no longer corrects the bitflip
> where it really happens.
[...]

This seesm to be a bug fix for commit bd2e778c9ee3 "gpmi-nand: Handle
ECC Errors in erased pages".  That's not in 4.4 so the bug fix is not
needed, though it doesn't appear to do any harm.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
