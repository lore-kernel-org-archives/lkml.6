Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	URIBL_BLOCKED,URIBL_RHS_DOB,WEIRD_PORT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C577C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7E82083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 15:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQbQJ1VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7E82083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIATnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 15:43:20 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46876 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeIATnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 15:43:19 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so6060810ywc.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/1yOBERLL72xv3eL3W7YQO1v+sGBFngBCEjGRzVti3U=;
        b=MQbQJ1VZC+6KYopiSJ2Dqt554wqe2dwCwRaQuu2ZJuIqyqzU952BOL4wippj2Xy5NK
         2t6D4edDmM0NAzt1se5YaMzJaTGTGAYLiAIlc9vHK7uPwyaBDclISru9saxt+I+gwTx5
         oOqGBYihdYaM3Whpk9AjK+/0h1qkoTdEShG3Vi0fnJ3iU3dcvG65GcDtFwICV6XBVqi4
         yzUMuXwU0uzgWPo8rW5hBYyAaaKzxJxehUAIfI5BaIxnLlrtHq6tHe0vuuByxbJddPrs
         iUi3D4AJtTqJqXnwU9k2XJoVtz4orUT7TxfhuzwqpZokXUCqOYZHz0vwqM3SfXw7ASWy
         oA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/1yOBERLL72xv3eL3W7YQO1v+sGBFngBCEjGRzVti3U=;
        b=ozAI3dhPLJsQVSDO3UxrgH2nL57NXeVHmeRe3WcVjBwvgZ+nuOVzsoHLPc60rSfOAt
         0uFuQSFCoaFsup49Ia+kkH6xnMTY6TDwdpNQkyGTMfcp6KBGUHxmHC0IdVXtjId0pj3a
         9a3AaS4VZDu1NsuBjflm24pjk+WiTzJq/Z5wSbBUKdT+I/EhxZKjdoTv5YgdEVae7NCH
         ynSr4+4sR+Xju6dPOoD2ndEdTD8+ft9jd7PGgZJjxbh3c1T9ruh+lJRz1VSQQGoVEuvc
         ZRWGuOwgSOTfMUGt8qfdlsX9A8Kfv+linSKUoB6Nrr2TtL/trKTcNYnX6Q7BOkhwUGra
         GFyg==
X-Gm-Message-State: APzg51BPUU2gac85q81Kb7wJFcmRK8unCD2wEUoqNHHfK5gEFR/UeSW4
        +rN8Emi7jhg1clrw3FG9hvGQpdWcneEy6Weengx8QbA=
X-Google-Smtp-Source: ANB0VdbSSK4HvZJ5FhV33rtdhKd9TVUpHZlvTvK2bgyrP5HaqOOP4siUDAaqiGIv5Wc8wQXCiJdrxgdOzVamAxPZrzk=
X-Received: by 2002:a81:d305:: with SMTP id y5-v6mr11974836ywi.141.1535815855734;
 Sat, 01 Sep 2018 08:30:55 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Sat, 1 Sep 2018 23:29:35 +0800
Message-ID: <CANnei0HpsaJC2u_ACWTET1MBHoDXu1-ZJtUZ6Ue1=ucx7+NL7w@mail.gmail.com>
Subject: Step-by-Step Tutorial: How to Deploy cPanel Web Hosting Control Panel
 version 11.74 on CentOS 7.5 Linux Server version 1805 in Amazon AWS Cloud
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step-by-Step Tutorial: How to Deploy cPanel Web Hosting Control Panel
version 11.74 on CentOS 7.5 Linux Server version 1805 in Amazon AWS
Cloud

Secondary Subject/Topic: How to Setup a New Startup Web Hosting
Company Using cPanel Web Hosting Control Panel version 11.74, CentOS
7.5 Linux Server version 1805, and Amazon AWS Cloud

Tertiary Subject/Topic: How to Startup Your Own Internet Business Like
China's Billionaire Jack Ma. Will Teo En Ming Be Able to Emulate Jack
Ma?

Objective: Experimental and Feasibility Studies for Teo En Ming's
Startup Internet Business

AUTHOR OF THIS TUTORIAL: MR. TURRITOPSIS DOHRNII TEO EN MING (ZHANG
ENMING) @ TIME TRAVELLER
ACADEMIC QUALIFICATIONS:
(1) Bachelor of Engineering (Second Class Lower Honours) in Mechanical
Engineering from National University of Singapore (Graduated DEC
2006), with Electives in Aerospace Engineering
(2) Part Time Diploma (Conversion) in Computer Networking with 4
Distinctions from Singapore Polytechnic (Graduated 2017)
(3) Full Time Diploma in Mechatronics Engineering with Merit from
Singapore Polytechnic (Graduated 1998)
(4) Certificate of Completion for CISCO Certified Network Associate
(CCNA) 5-DAY Boot Camp from NTUC Learning Hub, Singapore, Year 2017
(5) National Infocomm Competency Framework (NICF) (Singapore)
Certificate in Configuring a CISCO Router, Year 2017
(6) National Infocomm Competency Framework (NICF) (Singapore)
Certificate in Configuring a CISCO Switch, Year 2017
(7) GCE "O" Levels with 7 A1s and 1 A2, Top Student Award, Graduated 1994
(8) Primary School Leaving Examination (PSLE) Score of 238, Graduated 1990
AGE: 40 YEARS OLD (as at 1ST SEPTEMBER 2018)
COUNTRY OF RESIDENCE: REPUBLIC OF SINGAPORE
DATE: 1ST SEPTEMBER 2018 SATURDAY
TIME: 8:30 PM SINGAPORE TIME, GREENWICH MEAN TIME+8
PRIMARY EMAIL: teo.en.ming AT gmail.com
SECONDARY EMAIL: teo.en.ming.BUSINESS AT gmail.com

DOCUMENT VERSION: 1809.01

COPYRIGHT (C) 2018 TURRITOPSIS DOHRNII TEO EN MING. This step-by-step
tutorial is written by Teo En Ming in Singapore.

NB: This document consists of a total of 251 steps.

SECTION 1: DEPLOYING THE CPANEL DNSONLY DOMAIN NAME SERVERS
===========================================================

001. Login to your Amazon AWS Cloud account.

002. Click Services > Compute > EC2

003. Click Network and Security > Elastic IPs

004. Click Allocate new address. Click Allocate. New address request
succeeded, for example, 13.58.134.234.

005. Click Instances > Instances. Click Launch Instance.

006. Click AWS Marketplace.

007. Search for CentOS.

008. Select CentOS 7 (x86_64) - with Updates HVM Amazon Machine Image
(AMI). Click Continue.

009. Select General Purpose, t2.micro, 1 vCPU, 1 GB RAM (FREE TIER ELIGIBLE).

010. Click Next: Configure Instance Details.

011. Select Network: <Your VPC network>

012. Select Subnet: <Your subnet> | Public subnet | us-east-2a

013. Click Protect against accidental termination.

014. Click Next: Add Storage

015. Click Next: Add Tags

016. Enter Key = Name and Value = CPANEL NAME SERVER 1

017. Click Next: Configure Security Group

018. Click Select an existing security group

019. Select NS_SG (Name Server Security Group).

020. Click Review and Launch. Click Launch.

021. Select a key pair.

022. Click Network and Security > Elastic IPs.

023. Select Elastic IP 13.58.134.234.

024. Click actions > associate address.

025. Select Instance: CPANEL NAME SERVER 1

026. Click Allow Elastic IP to be reassociated if already attached.

027. Click Associate.

028. Login to CentOS 7 Linux Server using Putty. Use centos as username.

Follow the Installation Guide - cPanel DNSONLY Installation at
https://documentation.cpanel.net/display/74Docs/Installation+Guide+-+cPanel+DNSONLY+Installation

SECTION 2: INSTALLING CPANEL DNSONLY NAME SERVER 1
==================================================

029. cd /home

030. sudo curl -o latest-dnsonly -L
https://securedownloads.cpanel.net/latest-dnsonly

031. sudo sh latest-dnsonly

032. sudo /scripts/configure_firewall_for_cpanel

033. sudo passwd root

034. Go to https://13.58.134.234:2087 and login.

035. Click I Agree. Go to Step 2

036. Enter Server Contact Email Address.

037. Enter Server Hostname, for example, ns1.teo-en-ming-corp.com

038. Enter Primary Resolver, e.g. 8.8.8.8

039. Enter Secondary Resolver, e.g. 8.8.4.4

040. Click Save and Go to Step 3.

041. Click Skip this step and use my server's default settings.

042. Select BIND DNS Server.

043. Nameserver 1: ns1.teo-en-ming-corp.com

044. Nameserver 2: ns2.teo-en-ming-corp.com

045. Request another Elastic IP address in Amazon AWS Cloud as per
steps above, e.g. 52.15.109.147

046. Click Configure Nameserver A Records

047. ns1.teo-en-ming-corp.com IPv4: 13.58.134.234

048. ns2.teo-en-ming-corp.com IPv4: 52.15.109.147

049. Click Finish.

050. Login to your domain registrar, e.g. godaddy.com

051. Select your domain name, e.g. teo-en-ming-corp.com

052. Click Manage DNS. Click Host names. Click Add.

053. Map ns1.teo-en-ming-corp.com to 13.58.134.234. Click Save.

054. Click Add.

055. Map ns2.teo-en-ming-corp.com to 52.15.109.147. Click Save.

056. Select your domain name, e.g. teo-en-ming-corp.com

057. Click Manage DNS.

058. Under Nameservers, click Change. Select Custom.

059. Under Nameserver, enter ns1.teo-en-ming-corp.com and
ns2.teo-en-ming-corp.com

060. Log out from your domain registrar, e.g. godaddy.com

061. You should now be able to access https://ns1.teo-en-ming-corp.com:2087/

SECTION 3: INSTALLING CPANEL DNSONLY NAME SERVER 2
==================================================

062. Go to Amazon AWS Management Console.

063. Click Instances > Instances.

064. Click Launch Instance.

065. Click AWS Marketplace.

066. Search for CentOS.

067. Select CentOS 7 (x86_64) - with Updates HVM Amazon Machine Image
(AMI). Click Continue.

068. Select General Purpose, t2.micro, 1 vCPU, 1 GB RAM (FREE TIER ELIGIBLE).

069. Click Next: Configure Instance Details.

070. Select Network: <Your VPC network>

071. Select Subnet: <Your subnet> | Public subnet | us-east-2a

072. Click Protect against accidental termination.

073. Click Next: Add Storage.

074. Click Next: Add Tags.

075. Enter Key = Name and Value = CPANEL NAME SERVER 2

075. Click Next: Configure Security Group

076. Click Select an existing security group

077. Select NS_SG (Name Server Security Group).

078. Click Review and Launch. Click Launch.

079. Select a key pair.

080. Click Launch Instances.

081. Click Network and Security > Elastic IPs.

082. Select 52.15.109.147.

083. Click Actions > Associate address.

084. Select Instance: CPANEL NAME SERVER 2

085. Click Allow Elastic IP to be reassociated if already attached.

086. Click Associate.

087. Login to CentOS 7 Linux Server using Putty. Use centos as username.

088. cd /home

089. sudo curl -o latest-dnsonly -L
https://securedownloads.cpanel.net/latest-dnsonly

090. sudo sh latest-dnsonly

091. sudo /scripts/configure_firewall_for_cpanel

092. sudo passwd root

093. Go to https://ns2.teo-en-ming-corp.com:2087 and login.

094. Click I Agree. Go to Step 2.

095. Enter Server Contact Email Address.

096. Enter Server Hostname: ns2.teo-en-ming-corp.com

097. Enter Primary Resolver, e.g. 8.8.8.8

098. Enter Secondary Resolver, e.g. 8.8.4.4

099. Click Save and Go to Step 3.

100. Click Skip this stemp and use my server's default settings.

101. Select BIND DNS Server.

102. Nameserver 1: ns1.teo-en-ming-corp.com

103. Nameserver 2: ns2.teo-en-ming-corp.com

104. Click Configure Nameserver A Records

105. ns1.teo-en-ming-corp.com IPv4: 13.58.134.234

106. ns2.teo-en-ming-corp.com IPv4: 52.15.109.147

107. Click Finish.

SECTION 4: INSTALLING THE CPANEL WEB/VIRTUAL SERVER
===================================================

Follow the Installation Guide at
https://documentation.cpanel.net/display/74Docs/Installation+Guide

108. Click Network and Security > Elastic IPs

109. Click Allocate new address. Click Allocate.

110. New address request succeeded, e.g. 18.223.26.190

111. Click Instances > Instances.

112. Click Launch Instance.

113. Click AWS Martketplace.

114. Search for CentOS.

115. Select CentOS 7 (x86_64) - with Updates HVM Amazon Mage Image
(AMI). Click Continue.

116. Select General purpose, t2.micro, 1 vCPU, 1 GB RAM (FREE TIER ELIGIBLE).

117. Click Next: Configure Instance Details.

118. Select Network: <Your VPC network>

119. Select Subnet: <Your subnet> | Public subnet | us-east-2a

120. Click Protect against accidental termination.

121. Click Next: Add Storage.

122. Change Size (GiB) from 8 to 30. It is still free tier eligible.

123. Click Next: Add Tags.

124. Enter Key = Name and Value = CPANEL WEB SERVER

125. Click Next: Configure Security Group

126. Click Select an existing security group.

127. Select VS_SG (Virtual Server Security Group).

128. Click Review and Launch. Click Launch.

129. Select a key pair.

130. Click Launch Instances.

131. Click Network and Security > Elastic IPs.

132. Select 18.223.26.190

133. Click Actions > Associate address.

134. Select Instance: CPANEL WEB SERVER.

135. Click Allow Elastic IP to be reassociated if already attached.

136. Click Associate.

137. Login to CentOS 7 Linux Server using Putty. Use centos as username.

138. sudo passwd root

139. su - root

140. cd /home && curl -o latest -L
https://securedownloads.cpanel.net/latest && sh latest

141. /scripts/configure_firewall_for_cpanel

142. Go to https://18.223.26.190:2087 which is your Virtual Server and login.

143. Click I Agree. Go to Step 2.

144. Enter Server Contact Email Address.

145. Enter Server Hostname: cpanel.teo-en-ming-corp.com

146. Enter Primary Resolver, e.g. 8.8.8.8

147. Enter Secondary Resolver, e.g. 8.8.4.4

148. Click Save and Go to Step 3.

149. Click Skip this step and use my server's default settings.

150. Under Nameserver Configuration, select Disabled. DNS Server is
not necessary for a Virtual Server.

151. Nameserver 1: ns1.teo-en-ming-corp.com

152. Nameserver 2: ns2.teo-en-ming-corp.com

153. Click Configure Nameserver A Records

154. ns1.teo-en-ming-corp.com IPv4: 13.58.134.234

155. ns2.teo-en-ming-corp.com IPv4: 52.15.109.147

156. Click Save and Go to Step 5.

157. Under FTP Configuration, select Pure-FTPD.

158. Click Enable Brute Force Protection. Select Everything.

159. Click Save and Go to Step 6.

160. Click Use filesystem quotas.

161. Click Finish.

162. Click Go to WHM.

163. Enable Global DCV Passthrough.

164. Enable The SSL/TLS Wizard in cPanel.

165. Click Save Settings.

SECTION 5: CONFIGURING CPANEL DNS CLUSTER
=========================================

SECTION 5.1: CONFIGURING DNS CLUSTER FOR THE PRIMARY NAME SERVER
NS1.TEO-EN-MING-CORP.COM
=========================================================================================

166. Go to https://ns1.teo-en-ming-corp.com:2087

167. Click Clusters > DNS Cluster.

168. Click Enable DNS Clustering.

169. Click Return to Cluster Status.

170. Go to https://ns2.teo-en-ming-corp.com:2087

171. Click Clusters > DNS Cluster

172. Click Enable DNS Clustering.

173. Click Return to Cluster Status.

For the following steps, please refer to Part 3: How I Built a cPanel
Hosting Environment on Amazon AWS at
https://blog.cpanel.com/part-3-how-i-built-a-cpanel-hosting-environment-on-amazon-aws/

174. Go to https://ns1.teo-en-ming-corp.com:2087

175. Click Development > Manage API Tokens. API = Application
Programming Interface.

176. Click Generate Token.

177. Enter name: NS1

178. Click Everything

179. Click Save.

180. Copy your API token from Name Server 1 to the clipboard.

181. Go to https://18.223.26.190:2087 which is your Virtual Server.

182. Click Clusters > DNS Cluster

183. Click Enable DNS Clustering

184. Click Return to Cluster Status.

185. Select Backend Type: cPanel

186. Click Configure.

187. Remote cPanel & WHM DNS host: ns1.teo-en-ming-corp.com

188. Remote server username: root

189. Paste the API token from Name Server 1.

190. Click Setup Reverse Trust Relationship

191. Set DNS Role to Synchronize Changes.

192. Click Submit.

193. Click Return to Cluster Status

194. Go to https://18.223.26.190:2087 which is your Virtual Server.

195. Click Development > Manage API Tokens.

196. Click Generate Token.

197. Enter Name: VS

198. Click Everything.

199. Click Save.

200. Copy the API Token from the Virtual Server to the clipboard.

201. Go to https://ns1.teo-en-ming-corp.com:2087

202. Click Clusters > DNS Cluster

203. Click Configure.

204. Remote cPanel & WHM DNS host: cpanel.teo-en-ming-corp.com

205. Remote server username: root

206. Paste the API Token from the Virtual Server.

207. Click Setup Reverse Trust Relationship.

208. Set DNS Role to Standalone.

209. Click Submit.

It says DNS Lookup Failed for cpanel.teo-en-ming-corp.com

210. Go to https://18.223.26.190:2087 which is your Virtual Server.

211. Click DNS Functions. Click Add an A Entry for Your Hostname.

212. Hostname: cpanel.teo-en-ming-corp.com

213. Server Main IP: 18.223.26.190

214. Click Add Entry.

Added cpanel.teo-en-ming-corp.com ok

You should now be able to ping cpanel.teo-en-ming-corp.com

215. Go to https://ns1.teo-en-ming-corp.com:2087

216. Click Clusters > DNS Cluster

217. Click Configure.

218. Remote cPanel & WHM DNS host: cpanel.teo-en-ming-corp.com

219. Remote server username: root

220. Copy the API Token from the Virtual Server.

221. Click Setup Reverse Trust Relationship.

222. Set DNS Role to Standalone.

223. Click Submit.

224. Click Return to Cluster Status.

SECTION 5.2: CONFIGURING DNS CLUSTER FOR THE SECONDARY NAME SERVER
NS2.TEO-EN-MING-CORP.COM
===========================================================================================

225. Go to https://ns2.teo-en-ming-corp.com:2087

226. Click Development > Manage API Tokens

227. Click Generate Token

228. Enter Name: NS2

229. Click Everything

230. Click Save.

231. Copy the API Token from Name Server 2 to the clipboard.

232. Go to https://18.223.26.190:2087 which is your Virtual Server.

233. Click Clusters > DNS Cluster

234. Click Configure.

235. Remote cPanel & WHM DNS host: ns2.teo-en-ming-corp.com

236. Remote server username: root

237. Paste the API Token from Name Server 2.

238. Click Setup Reverse Trust Relationship.

239. Set DNS Role to Synchronize Changes.

240. Click Submit.

241. Go to https://ns2.teo-en-ming-corp.com:2087

242. Click Clusters > DNS Cluster

243. Click Configure.

244. Remote cPanel & WHM DNS host: cpanel.teo-en-ming-corp.com

245. Remote server username: root

246. Paste the API Token from the Virtual Server.

247. Click Setup Reverse Trust Relationship

248. Set DNS Role to Standalone.

249. Click Submit

250. Click Return to Cluster Status

SECTION 6: CONCLUSION
=====================

251. You should now be able to access your Virtual Server at
https://cpanel.teo-en-ming-corp.com:2087/

===END OF TUTORIAL===

If you happen to find any mistake with my step by step tutorial,
please drop me a message.





===BEGIN SIGNATURE===

Turritopsis Dohrnii Teo En Ming's Academic Qualifications as at 30 Oct 2017

[1] https://tdtemcerts.wordpress.com/

[2] http://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

===END SIGNATURE===
