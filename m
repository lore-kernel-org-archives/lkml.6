Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755301AbeDYQuh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:50:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:47651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754838AbeDYQug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:50:36 -0400
Message-ID: <1524675033.8257.4.camel@gmx.de>
Subject: Re: DOS by unprivileged user
From: Mike Galbraith <efault@gmx.de>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Ferry Toth <ftoth@telfort.nl>, linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2018 18:50:33 +0200
In-Reply-To: <20180425155459.5a4e40e0@alans-desktop>
References: <9023506.UBh6vynRGa@delfion> <4285098.DEWjdbWF2X@delfion>
         <1524325275.8078.2.camel@gmx.de> <6057755.ozdVOybsI6@delfion>
         <1524470676.5451.1.camel@gmx.de> <20180425155459.5a4e40e0@alans-desktop>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RCkwvkEN2nD76e6SzT4OR1yXzHRQVAMfRBydAdUnJJx9qbcT0AL
 FetE/Q2O4K5RgCR57pgIq5XnTgJv2w9Jub7RbBm4yMYiUuznST/C1Pi/Xx5+Jgr2fOrPN36
 kTf8dMs8vhQyFfeXrZE0d3o/wbNWREnhFL40asjjUVDQhqoYRoFL7NNOXhBNrQHLlarkKdH
 JgSM73t3TkuYWlffB9Dkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MlyytE8bgsU=:urmfK/EmDGw9Otz+u/u8Kj
 8Q4v9KaFKqnZ16GdCC7q3OBJa+4CraOII82xfO0KHBF60Il7mcUOpf3VAXiJiXk23IqgdR27c
 5EuzCGuzwb3sWozohdHSZ8V92WzdfnR0d1UCEvIG2WTaBW0XOleaIZQKcNwDaMgeP5w4+SXvm
 raxLv51bTVW65oTNgINLuSEhu6GyuLiWr+QqKaUj1jjbfyKSe3MtuBMAQzzKDuzuLdg7AiroI
 7hsDZChoDlrdEeLkJN4BpMuhpWftAAtcJKXqqaIppgxJW6lPhOlt3qFUyKrwa/Pex7XLdGmn5
 YVsVCZjdhsTd7OViMSECO/C1K/VdDomdCtWHj5x0Ovzmaq2MIxHzG5vCmJC7yjIToiXeOKqIr
 bk0AEcZDMfiX4I/8o7o2d7960RyfdRXaF23bGv5Vm1W24xXYAA4HETuJubAIt/ULDTZkj9AYm
 UY/1aAth1SNNwIZ1ZUTX234axMyC6t3akn4TFeko6gqCYKN21ncM0MKcEU2zKuB1I4uHeOOes
 WeKS9zgSAawPpnudOZYHexGQ3xfx6QhEj7aJutd31hcW2CYmV59708ie03a0XaOOxgwVvgbdn
 dpPIcupeuc+QUPiiYvXWTEkda/4n5SgXVDqpe7hBNWLhSaJ2UCLbozy4IqZ75Q3FT9zHXIkXg
 Oj9h217/lq0K4pBa43IUm1tbBKfrnjXEbj0ZjZkXPRLqAxYi+TJ8tLMaa1Z25ux7kYVreoG7B
 8Mt5XzJoE3Od5Jhfmyfl0QLPB2FBB2RNFyfrOkPlad1WauhWvdaKAib+Vo9aIkqc2Tc2YIkJB
 /LYJ031
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 15:54 +0100, Alan Cox wrote:
> 
> Classical Unix systems never had this problem because they respond to
> thrashing by ensuring that all processes consumed CPU and made some
> progress. Linux handles it by thrashing itself to dealth while BSD always
> handled it by moving from paging more towards swapping and behaving like
> a swap bound batch machine.

Memcg constrained the gitk hog nicely, forcing it do dig into swap
after hitting its limit.  Dunno if there are any userspace bits that
can use it wisely though.

	-Mike
