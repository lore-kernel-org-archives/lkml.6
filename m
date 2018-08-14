Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A524C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CA421736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CA421736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeHNVW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:22:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:2177 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbeHNVW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:22:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 11:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,239,1531810800"; 
   d="gz'50?scan'50,208,50";a="248823145"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga005.jf.intel.com with ESMTP; 14 Aug 2018 11:33:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fpe8N-000AHR-Uf; Wed, 15 Aug 2018 02:33:35 +0800
Date:   Wed, 15 Aug 2018 02:33:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2018.08.05a 251/252] kernel/rcu/rcu.h:440:20: error: two or
 more data types in declaration specifiers
Message-ID: <201808150207.6gsk94Tx%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2018.08.05a
head:   4ad5aae97b17143dae19dcef5984c5e47417064a
commit: 411ec41811aa1c759a8c717edf917f9f00ca731e [251/252] srcu: Make call_srcu() available during very early boot
config: ia64-allnoconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 411ec41811aa1c759a8c717edf917f9f00ca731e
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/update.c:58:
>> kernel/rcu/rcu.h:440:20: error: two or more data types in declaration specifiers
    static inline void void srcu_init(void) { }
                       ^~~~

vim +440 kernel/rcu/rcu.h

   436	
   437	#ifdef CONFIG_SRCU
   438	void srcu_init(void);
   439	#else /* #ifdef CONFIG_SRCU */
 > 440	static inline void void srcu_init(void) { }
   441	#endif /* #else #ifdef CONFIG_SRCU */
   442	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICAQec1sAAy5jb25maWcAjVxZcxu5rn6fX9E1U3UrqTrJeItj31t5oNhsiaPeQrIl2S9d
itxxVLElHy0zk39/AVJLL6DsqlnsBriBBPABBP3Hb38EbLtZPk8389n06elX8FgtqtV0Uz0E
3+dP1f8FYRakmQlEKM1HYI7ni+2/f86n11fB1cfzm49nH1azT8GwWi2qp4AvF9/nj1toPl8u
fvvjN/jnD/j4/AI9rf43wFYfnrCDD4+zWfCuz/n74Obj+cczYORZGsl+mfcN68WijMVIxPrL
5f4756XUJbT48mv/CX4pR0JpmaVfbs7Oz84OvDFL+wfSmZtG367rKVhXm+3LcbyeyoYiLbO0
1El+7Fum0pQiHZVM9ctYJtJ8ubzAxexGyJJcwiyN0CaYr4PFcoMd71vHGWfxfvzffz+2qxNK
VpiMaByKiBWxKQeZNilLxJff3y2Wi+p9rRt9p0cy5/XGx6mpTOsyEUmm7kpmDOMDkq/QIpY9
YvwBGwlYNh/ABGHTYSyYcwyisWKU6muw3n5b/1pvquejGPsiFUrCHqmvsHV9xu9q+1Sj5Srr
CZqkB9m4S0m0ROqRYGfGQZBDnRWKizJkhnXbGZmIctSaPM+LP810/TPYzJ+rYLp4CNab6WYd
TGez5XaxmS8ejysykg9LaFAyzrMiNTLtQzcH8Y2kMi1ymTIjR6IuUjuq4kWguyKDJncl0Oq9
wq+lmORCGXLP5ND94Nu1ItVOezQfiNBJqd4976usyDXZt2uCZ9IykTxKxOyOpPTiIRzckdUb
FRLzA13NctgUeS/KKFMlrBH+l7CUi8YMW2wafiB6w301sTsLRcpi2U/LNCvHTKXHo+AEWe89
Ab2ScPAVLYG+MAnTw3J3amimOx3pkxzRgKVhLEhanmk5sWdT0buQK5maIS3iok9/ZxpkVfhm
UxgxISkiz3xrBHGyOApJop28hwY2OzUemh6ATSIpTGb093AkYWk7WdPygj57TCnp2VI403yY
ZyBTOLvaZIreliH2f5fQQ/Ty6OR+43myFjuizj3MT4ShCOvHMOfnZ1cdM7HzoXm1+r5cPU8X
syoQf1cLME8MDBVHA1Wt1s6O7WxQ4iReWgvkO1Loq5gBR0cfKx0zygvouOjV56zjrOdtD9ug
+mLvufxskRLgdDRsBqhIRp+GJuOAqRAsOn2kwJlEMgbL67OHmeOoORz7+fqqB97dWg00eZwL
rVssQ+uoOl+VMCTBGiKjGBeDLBt2vRFgi1KGCBgGSrCw5c2MNTpGFdxYIAI+e3iCBQ4iwAg4
zG0e27dr7mWy000TWWoWiZIn+YQP+keePC76MrXYA6AWQJejXR4w7foGCRjBoWswuWlbtoRf
fJ0D5dTiSrLQTVjngstI1nAfkIpYaFS8UsSR9Uqt1mICG3yQdc1/RXbIjrl0CJFnow/fpmuA
vj+dLr6slgCCG7DAWludIKg4r5khNyWPawQvTJxQmcLRhb5ykHeRIlMT6Ozodk8d/RSNbDtW
0ghf4zpx19qKIV8tZ9V6vVwFm18vDiV9r6ab7apaH8Ug2fXVsUerUMdf7+FYlGHCLi+O374W
gKdQpWv7mBTHX+zJshpU6iLPM1VjVGMtkhIPKgvhVMT9DKY+SLpqBjZa9hQzaIoAqbQOhRam
yBF4uNMHwjsyhImsAYeo9ovDRRlEAGCVAI6X1p2Iul4hTLaHtSZjkM9+WvUTaL+Hkvbke2I5
MrTBswyDvLyfnL9GL/VYZiambbbl030wAunFaYZidHIgLRPqZBuWyiJpIC8+hGMnaPBoe8sZ
eBCEe+XV8MSsj2w3Q8pvtZjOr4e92jG4/3Lx6ezY4+C+hLCR8h73JTDWFwBfLpusrV6obuxk
eioGFFC0zkZ8DqcVjhbgIhmZL9etZfI7AO8pBX1lplleN4cAk0FpEjaxepeBv1Rfzmu2CXwP
0Y21rSK10cIuWBxkBs1/y2F0eBT8NKqZ/Rx8dZKbvTOoeWf3fZTFYHKZovd+x0UhEBGDl9kP
DBZWxPXuo5gZoMHC04LFRPtQavjJyP6RqwFocqbArLy1h5q8YWBYbGhlAo1rWYNUgKmwQUYO
IkOeGlA4DjiC/0C7nWjbjg8QY9NeNz7vRq6ParcJ5wpYiWiu8xjMU25sa7B8+stVCxxyI7OU
hteyD+a0Rd3v3OBOA0YPVWnaDiBVzt6Di9xDVXT6JoMgRtc3Yagp+7HPgFghJeAecZQvV2e3
1w1B7y35sGFpeCwgqETVotFwwsjv93mW0fj+vlfQ1vjewoCMTsPA5HBu4NYMDQv64It6IuWD
hCkKHjjwQ+pAe98Pp7x9oCzHXlFI4vFQkuRG77ttqW1zkdRcqD3uO3N2XjOyuPWgX3ttOZlx
wj4wnwMAzojUps8O/SPc20kVB3aKIMOunoCoAIvpg/41LWvCGeAmgHrCY5F2HgQwUkTHpbtu
SqEUYKm/YIMo62W9a2d0oeVJh8qSuEyjcQeb6jQIq7/ns6oRAOIgMuOXdFArJoJ3Oormq+d/
pqsqCFfzv1vxZCRVMgZcVDr7RIf4kYT4NaSJgKIkFQSHGG9wlsL+8wFiT/AVtqcIFKjHmkmq
fpb1wXruJ9NZAbQL3ol/N9ViPf/2VB1XJDFA/j6dVe8DvX15Wa429cXhcCPmiZGRyFmuC8w8
Zyz0pBOQrZ3ytWOY6nE1Db7vZ/JgZVsfvQenKTEYrtAxgiNrrmROx887jgQU0hPlKxEWTVfv
4Pzyn2oVPE8X08fquVpsLKBnPJfB8gXT9I0TkFPmGJlbdgH8wsDs9BaoZR7WAIn9ou+0AYXP
szFYabSCaBsOwP6Y40HeUPSKft8jc9dbzsHNoIHy8wjuOoroLXYj0aGYW4PKMBEAYS238+1M
88Dg66FpD+0nXmiTgenUIYQPmImo3wYcF++fMZpfBipzQjgDT3rEEvFUcHCWmEixup2lsQeJ
JRKTr0r0fWhgPyH4uSlke4R62/X+SAXvci7/E+Q84ZK9r13u8NpBgl9gPxJYnG5+PCbtaxkz
KfDoAHygkAg0SrRsNUAIooaeNCs/JXg7CVPQUQgSZUaHRUjLFW3hLY1p0j4iLWY9cbiogA/B
bLnYrJZPT6C9Dwdb7ZR1+lBhehC4qhrbOlgfzJ7lC6v1/HExRouEHfIl/KCbLPhdLB5elvNF
w1rijEQa2li3a1Kg0fqf+Wb2g55kU5BjDEUNHxjhQUocgStJSkV3cOcGa+7reLs3n+0+B1nX
tBUuVToQce5RplCMTJJ7zAeYhDRk7ZisHsbY7g8utFfIOOxM/uCrnpawhw0PEY1PeR4EmmN7
w0IZ+toS4EyXoZIj7xotgxgpT7bKMaCT23VTuniPVPeHLiRJPKmLLKKsZsuX5BxURLV9xO4T
pTdp3mBM8938E7DTrC+6RipfLTfL2fKplsqCVjsPZzlSiM7aWpLM1zNqsbAPyR3mzugzMWCp
8WW5HXK7IolGRondZxqEpDzOdKEwoaVGkns2EsCkjGkAqxWjZ1XX+g7QOUKNi/Z2OFwmwEEm
NRt0nLGllLeXfHJN99j7fH7WWfEOWf07XQO0W29W22d7G7L+AQr0EGxW08UaRwqe5guAXLBF
8xf8cb9p7Ang4DSI8j6rIbPlPwvUveB5+bAF8PhuVf13O19VMMQFf79vikjyKQB/GPxPsKqe
bDVEy7YeWVARwj3gc2Cdy4j4PMpy4uuxo8FyvfES+XT1QA3j5V++HPK4egMrCJIjBHzHM528
b9tQnF/YQa59kY6/ek4iH9AHDFFqqYye4InyBXwyFHud0xzCIqdfNTnvTysQMfRtJH8K3QIp
bvlCiOD88vYqeAeWthrDv++pAwlWWoylR7/2RAhS9F13iMXLdtOd6zGQS/OiqxsD2D0Xo/yZ
BdikGcYJJalKEMI8WtZGtMQSQaojBzWZzjbomA+Ga29fzF2jlIFW8yKVk9ubMjd3tIFxZR5+
Ok4Vwn4I9Zzv9Pn47D5LaMi0uw6QKX1zCV7Md6UMpKGP5iJzTxiFRAOGedKRpwZ8MX2iUM5u
oTcXn846rdLl4oMlrF1za7CIY7Pro2DKxNLQB3PHg1PE7DHINfPEQzvOv7RHAruOOE8nNI7Y
cbDYCMXKvwzr48zewPoqm/LI3ZFVTt9H7MiRjss4f20MREmtQOF4pMzdqRoLCUFQ6eo3aPw0
GJ+6u8b8gDL0CtXl7TXt7lmex5J7uhzkgl4szLJvyxtcRQa9Wg7/5l4VaduNA20i4/iuJUJn
/S44afQuPLua04qtc4/GDzzpsTwnoJzJg9nTcvaz7ZrFYop5oXxwhwVumO6AOGKcqSGmrK20
wCAlOdYNbJbQXxVsflTB9OFhjkEDKKntdf2xEcnIlBtFJ4j7ucxapXQH2pi+qHNpETbyRKeW
Cgjds/W7pEoB54YO5QfjxBPCm4FQCaPXMWYQpYUZVU2hdQ9rl7R0KeLjRmrqDq7HE0ay91rZ
dweut0+b+fftYobS33tWwswODLcBtCfdGYN3lJ5aR6RpDy2JwvIvlt6XHDCGpxIJeYYiyWPa
hSE5MdeXt5+9ZBXyy4tzuhAL6Tr5dEYfFdabfDrrguNm6ztM03vJRpYsubz8NCmN5iykdRUZ
R5ObT59o6yX6RYzlJHRbEUq2T+91Nri/mr78mM/WlOVgfdoBjfoMfAWtU6FKOmNABBe8Y9uH
+RKQ76GC4T1dkcySMIjn31bT1a9gtdxuIGg4gOBoNX2ugm/b798BOREp94ieEyaxY4vUYh5S
kjiqTFakVA6oABXLBpgIksbEAuMwyRrXH71uZQR+3JX16HLAGxi5IHUTW7g0nF0VMllM0kox
4ff8x681FoUH8fQXnd9Js9x2OOFC0hkxpPZZ2PdYMnOXe7JC2LCIc+n15MWY3okk8ZxvkWis
6fUkmsaAZ0Nf5hjTvrInYWdoews+H4vOtSelkjBwtu1A3SWzEtYrIioTr+9SbjPG9JSKSSh1
7qvGLTx2zN7CurQOPVVkkBnIKi26dno+Wy3Xy++bYPDrpVp9GAWP22pNo1kAjK2yvJpvwoqn
dk3UcZuYjHsZbShlliSF18yo6nm5qTDqpY4qZrEM5iG6V2Lq5Xn9SLbJE72XiV+X24GkixZg
nHfaVnwH2QKCsfkLRKIv1Wz+/ZClPCgbe35aPsJnveRtPeytltOH2fKZos0/JhPq+9ft9Ama
tNvUZo3l8Z0pT7DS7V9fowkWWk7KES9ISeR4PTyKlKBTYWJivA7KXtjS++0Re2po1Ydw0Gsu
8nHXaWDibgY70805MJWUfXx9wCZlquqVfjLH6krfKBaz2TsblcW+GCJKumcQkGnjjUA9/WJL
25CBdDw8KYdZytBgXni5EPjmE1Ze3KQJgmxPJr7Ohf350Sf3XA8nnN4axbrGjy0eVsv5QwMO
pKHKJI2yQkZbhbSdBXAZlzFmCGfzxSNtoOigCCv7YgDJ9L5hJpE0A9JjsHQsEyqMGuSBnj9v
n6abJelXXWWdC2dpMeucvNuHsMcdoUZ3YoIGM9KuFLXMPC9A0NvgC6Whz3RDDyLl6i731guF
aWZk5NFmRyu97y8idqL11yIztPTxyUqkr0rfva8l+6gRVpV4aFgiAh62JO46+XT2o4ULdafm
yCn2uto+LO1bOmJn0B/5hrc0PpBxqAQtbfsWhXayBSCuuOehuv/5hSIiOWLKR7XJXTwr7oqf
upBN49qVLvxyKB36fb5e3tx8uv1wXrsGRwaehcJWbV5d0kFUg+nzm5g+06FMg+nmE13T2WKi
LWGL6U3DvWHiN9dvmdM1HS62mN4y8Ws6oG4x0bmrFtNbRHBN3wG1mG5fZ7q9fENPt2/Z4NvL
N8jp9uoNc7r57JeT1Bme/fLm9W7OL94ybeDyHwKmuaSTafW5+NvvOfyS2XP4j8+e43WZ+A/O
nsO/13sOv2rtOfwbeJDH64s5f3015/7lDDN5U9L+70CmITaSE8ZLlSWM9gd7Di5i44F4RxZA
OoXy4Os9k8qYka8NdqdkHL8yXJ+JV1mUEJ7gfMcBEXTMUs8t0p4nLSSdamiI77VFmUINpaZh
IPIUJmpo8W+1B3w/prOf7smQ/fqymi82P20a+uG5gkDzGOwf3THe5AD06ttX7wdv+fnwUsaV
M3Q5rhpP7D/YZ82ATGY/13bA2e7pPZVgcIUS3iLXXdk/vqgF1lwJzoynzmz/QqDQxj24JBCB
ezpj3+denF3d1JG4kjkYq6T0PsDEV052BOa5zypSQHGYBU16meedqLWX2dhXR+eEEVFYZiCw
KEe7ldXza66NFrZ6HlFRgvlzGqi1mJxYvZV4u9nYdx1jwYb7SndPwgQDVcBizSqURldDodJj
cVlSPS9Xv4Kw+rZ9fHQntSmnQ/H1idkh44nqd+wmz8Aepr5gwnWT9bB++lQp0sh3feXqfGxh
PL46Jxa/f7TIUp6NdrfJOSf2cNAq4dkVmoF8gng5+7l9ceo0mC4eW5mUyD6rKLDuyL2J9EwW
iYDK0759yUkyjb+SNzA1maZYoAnnphXAUfRyxOJCfDlrEvHuKyvMl1p1vnve5t6MijTsKnBL
VtjFUIi8ta1WKiir47EK3q1f5gt7lfaf4Hm7qf6t4IdqM/v48eP7riU6mRXc7Ta+ZT9Zt8ZM
hlWsOoYZnmDbBbklw9JiEUdY6uQpcsCAGbbVYL2VtyJqPHZzO3RGW4HDE0e6E7QJoFL4VxyE
CGFXTtw07/Taqc+plUrPZHZaLF/j0Ke018br0pdMdjxcwVpSgBFxN4zGv4xBmiH8Oxj4FyL8
IkeOV/fFMnkFbv/Yxld9ohDYrQAU09li5bfCe0ngo5Bs/yzEZ0Hd6yaSZ+90sNwnKlLnNuwS
VOuhS+TsWeIeNOOLFtW4/gkTZs+3f3UKH18nTnyoDe2s/9HFiMQrYmvEU/tHWPCOUhX+5JBm
Se57JF30NKME4d7RgiLgy4zz66TXeVFjqzlAJPdMee5vQqktfBgNPG8r3Ltbd1rdg/jX2Ch/
oavZdjXf/KLA1lB4i6R4oaS5g+0S2uaPAQ95NHrPS8MUPBP7v5Zgc2w8y+8afwbgmB1qs/nM
FUQRlgcfnnULpw9K4s7zcSms9hikTW08gLC5xKwjSeJudtfgkA23RfiNV5CHPyWUdR9HYpJv
t7PWoisRNZ4MKghjuDSeclfFzz1lq9DOnJ+Fkn7Ug2RpwAL5qJ6sA1DoEBMIdIwby57tzvcX
oTidcnD+5fLitNua3MMmcvLIaZR2/W2s+4TZ5uYTVfweNh4L4gNO7axULNK+GbRoSMDnn/un
OPXttKaNfHiKlFAqBFsAgmpvYN1j+Mamg730hKTQNW0A8A9Ytf5ozt5+cX1hY5m0/X7aIlD8
SzRMNp4DOmZS9P8PgPQcK5VNAAA=

--u3/rZRmxL6MmkK24--
