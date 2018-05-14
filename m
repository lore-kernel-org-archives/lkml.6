Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1557870-1526338490-2-9432732576105144813
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526338489; b=FJgw3watKjSCv+8dNin/JsWImRpS6MabjCH4B0Ah6rM2v9KmVo
    uVQStqYIy4OToTQFeHs/iXk1TrCajECrWMN6HoviHWoBR/OfHkKWW5BHPCZTMoC/
    AKZrHDMCvjDISP8r6mf62vbiEl7mxdWsngNYfRoBuXTnGLCIXiVx2jMz+rLxdIq6
    w80PRh+kc64Oqf/LZ6+KaG6TNFUyNioRwHa4mP4An4l1fSKooDmZ9E1cZ5okfOU0
    NncdfpgEeYt16mI525ZI1Fh1YR70MJgfVGRPR1YN8Xd+HmKBRq+6gAK/v/GK+cIU
    MKajHsrINR8UAe4K8DxT1r30bNTbbOmQhIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:mime-version:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1526338489; bh=WX3lKGbLw08H
    DFZlsiMBfLOU+w1QxQGVcGMKdv7ClGM=; b=Wlr8TnbTNq9dLm5uJotQLZVjIr4e
    ++OPNlcOe8yTTSGPf8M3mxGdiHz9K0bUaYXYd/y/6nPBw3K/jOVfaGqkphO1aJKK
    O8g+Q0D1uHNd0Yord7+E8gjEckLwrDvzgyA3op7F1y86+MUQR2heZ4YAY8uwcNek
    OlaAs0zP5xIFjAKYzlcBfuf5YIyQdfT5+OqFLFY6KaD1/doeEOC48arwWzzndCuN
    3OFwc9NhwxC8NLvChVxnSlmd2Z/wygT7HN4D6LHCIquYxkmhlC4mthY5jWjWXdOy
    jaB87CxgMouQ5QeY7PT3zLjiRvSWoruIEtKCOEL6QXCrKM2vqGh1GCeEpg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFbV1zmnXTvZIp/ADzPnb8G7y+8eGbcN6BDF2AzqZt+k9oBVFQ+GDDh0uvBp17vGKmvNSh5KCrAPlcD6tZhKdufVRsAsMLSDVJr38V5r2YA7UEIW6MEd
    vkfIDrjo/zpN34p8jKYtG0SGxhO7gwNg45jfqNZD/XVYJpzNlDd2h4+W0pc+/ElnjIZVxxsRJ6XjjCVd05cjRdqP2JxCGRmANu14T9GqQWTZ/qDB2ANXAtri
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=mBCZbjKlWqhkfuZoNbYA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeENWyq (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 18:54:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752465AbeENWyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 18:54:35 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 6/8] kokr/locking/memory-barriers: De-emphasize smp_read_barrier_depends() some more
Date: Mon, 14 May 2018 15:55:31 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514225457.GA5142@linux.vnet.ibm.com>
References: <20180514225457.GA5142@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051422-0036-0000-0000-000002F4AA14
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032370; UDB=6.00527777; IPR=6.00811502;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 22:54:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051422-0037-0000-0000-00004455C75B
Message-Id: <1526338533-6044-6-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140226
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: SeongJae Park <sj38.park@gmail.com>

This commit applies an upstream change, commit f28f0868feb1
("locking/memory-barriers: De-emphasize smp_read_barrier_depends() some
more") to the Korean version documentation.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../translations/ko_KR/memory-barriers.txt         | 27 ++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 99ef4ca1c1bf..21e78af7ee93 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -80,7 +80,7 @@ Documentation/memory-barriers.txt
 
      - 메모리 배리어의 종류.
      - 메모리 배리어에 대해 가정해선 안될 것.
-     - 데이터 의존성 배리어.
+     - 데이터 의존성 배리어 (역사적).
      - 컨트롤 의존성.
      - SMP 배리어 짝맞추기.
      - 메모리 배리어 시퀀스의 예.
@@ -576,8 +576,14 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 	    Documentation/DMA-API.txt
 
 
-데이터 의존성 배리어
---------------------
+데이터 의존성 배리어 (역사적)
+-----------------------------
+
+리눅스 커널 v4.15 기준으로, smp_read_barrier_depends() 가 READ_ONCE() 에
+추가되었는데, 이는 이 섹션에 주의를 기울여야 하는 사람들은 DEC Alpha 아키텍쳐
+전용 코드를 만드는 사람들과 READ_ONCE() 자체를 만드는 사람들 뿐임을 의미합니다.
+그런 분들을 위해, 그리고 역사에 관심 있는 분들을 위해, 여기 데이터 의존성
+배리어에 대한 이야기를 적습니다.
 
 데이터 의존성 배리어의 사용에 있어 지켜야 하는 사항들은 약간 미묘하고, 데이터
 의존성 배리어가 사용되어야 하는 상황도 항상 명백하지는 않습니다.  설명을 위해
@@ -2802,8 +2808,9 @@ CPU 2 는 C/D 를 갖습니다)가 병렬로 연결되어 있는 시스템을 
 
 
 여기에 개입하기 위해선, 데이터 의존성 배리어나 읽기 배리어를 로드 오퍼레이션들
-사이에 넣어야 합니다.  이렇게 함으로써 캐시가 다음 요청을 처리하기 전에 일관성
-큐를 처리하도록 강제하게 됩니다.
+사이에 넣어야 합니다 (v4.15 부터는 READ_ONCE() 매크로에 의해 무조건적으로
+그렇게 됩니다).  이렇게 함으로써 캐시가 다음 요청을 처리하기 전에 일관성 큐를
+처리하도록 강제하게 됩니다.
 
 	CPU 1		CPU 2		COMMENT
 	===============	===============	=======================================
@@ -2833,9 +2840,9 @@ CPU 2 는 C/D 를 갖습니다)가 병렬로 연결되어 있는 시스템을 
 액세스를 위해서도 이 분할된 캐시들 사이의 조정을 해야만 합니다.  Alpha 는 가장
 약한 메모리 순서 시맨틱 (semantic) 을 선택함으로써 메모리 배리어가 명시적으로
 사용되지 않았을 때에는 그런 조정이 필요하지 않게 했으며, 이는 Alpha 가 당시에
-더 높은 CPU 클락 속도를 가질 수 있게 했습니다.  하지만, Alpha 아키텍쳐 전용
-코드와 READ_ONCE() 매크로 내부에서를 제외하고는 smp_read_barrier_depends() 가
-사용되지 않아야 함을 알아두시기 바랍니다.
+더 높은 CPU 클락 속도를 가질 수 있게 했습니다.  하지만, (다시 말하건대, v4.15
+이후부터는) Alpha 아키텍쳐 전용 코드와 READ_ONCE() 매크로 내부에서를 제외하고는
+smp_read_barrier_depends() 가 사용되지 않아야 함을 알아두시기 바랍니다.
 
 
 캐시 일관성 VS DMA
@@ -2997,7 +3004,9 @@ Alpha CPU 의 일부 버전은 분할된 데이터 캐시를 가지고 있어서
 메모리 일관성 시스템과 함께 두개의 캐시를 동기화 시켜서, 포인터 변경과 새로운
 데이터의 발견을 올바른 순서로 일어나게 하기 때문입니다.
 
-리눅스 커널의 메모리 배리어 모델은 Alpha 에 기초해서 정의되었습니다.
+리눅스 커널의 메모리 배리어 모델은 Alpha 에 기초해서 정의되었습니다만, v4.15
+부터는 리눅스 커널이 READ_ONCE() 내에 smp_read_barrier_depends() 를 추가해서
+Alpha 의 메모리 모델로의 영향력이 크게 줄어들긴 했습니다.
 
 위의 "캐시 일관성" 서브섹션을 참고하세요.
 
-- 
2.5.2
